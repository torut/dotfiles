#!/usr/bin/env python3
"""iptables ブロックリストの統合作業を支援する決定的ヘルパー。

rdap_lookup.py が「各 IP の登録ブロック」を埋める一方、こちらはその前後の
機械的な処理（複数ファイルのマージ、冗長検出、/24 バケット化、登録ブロック
ごとの集計、包含検証、最終リスト生成）を一手に引き受ける。すべて Python 標準
ライブラリのみ。Windows でも壊れないよう入出力は UTF-8 を強制する。

サブコマンド:
  analyze   FILES...                      手順1(冗長) + 手順2(/24バケット) + サーバ間重複
            [--dump-ips OUT]              ユニーク単一IPを1行1件で書き出し(rdap_lookup.py 用)
  hotblocks --rdap TSV --min N FILES...   登録ブロックごとに個別IP数を集計し N件以上を抽出
  check     --cidr C [--cidr C ...] FILES...  指定CIDRが各単一IPを実際に包含するか検証
  build     FILES... --add C[,C...] -o OUT     最終マージリスト(素の一覧)を生成

ファイルは `iptables -L` 出力 / 保存済みブロックリスト / 1行1IP の素のリストに対応。
ファイル名(拡張子を除く)をサーバ名として扱う。
"""
import sys, re, argparse, ipaddress, collections

IP_RE = re.compile(r'\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(?:/\d{1,2})?)\b')
HYPER = re.compile(
    r'MSFT|MICROSOFT|GOOGL|GOOGLE|AMAZON|AWS|ORACLE|DIGITALOCEAN|TENCENT|'
    r'ACEVILLE|ALIBABA|ALISOFT|OVH|HETZNER|AKAMAI|CLOUDFLARE|LINODE|CONTABO',
    re.I)


def read_text(path):
    """UTF-8 を試し、ダメなら cp932 でデコード（Windows で保存されたファイル対策）。"""
    raw = open(path, "rb").read()
    for enc in ("utf-8", "cp932", "latin-1"):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return raw.decode("utf-8", "replace")


def parse_files(paths):
    """{server -> (singles set, cidrs set)} と統合した singles/cidrs(各 -> servers) を返す。"""
    singles = collections.defaultdict(set)
    cidrs = collections.defaultdict(set)
    for path in paths:
        server = re.sub(r'\.[^.]+$', '', path.replace("\\", "/").split("/")[-1])
        for line in read_text(path).splitlines():
            toks = [t for t in IP_RE.findall(line) if t != "0.0.0.0/0"]
            if not toks:
                continue
            src = toks[0]  # iptables -L では先頭が source、素のリストでは唯一のトークン
            (cidrs if "/" in src else singles)[src].add(server)
    return singles, cidrs


def net(s):
    return ipaddress.ip_network(s, strict=False)


def sort_key(s):
    n = net(s)
    return (int(n.network_address), n.prefixlen)


def supernet(ips):
    """全 IP を覆う最小の単一 CIDR。"""
    nums = [int(ipaddress.ip_address(ip)) for ip in ips]
    lo, hi = min(nums), max(nums)
    pl = 32
    while pl > 0:
        n = ipaddress.ip_network((lo, pl), strict=False)
        if int(n.network_address) <= lo and hi <= int(n.broadcast_address):
            return n
        pl -= 1
    return ipaddress.ip_network((lo, 0))


def cmd_analyze(args):
    singles, cidrs = parse_files(args.files)
    nets = [net(c) for c in cidrs]
    print(f"# 入力: 単一IP {len(singles)} / CIDR {len(cidrs)}  ファイル {len(args.files)}")
    print("\n## 既存CIDR")
    for c in sorted(cidrs, key=sort_key):
        print(f"  {c:20s} servers={sorted(cidrs[c])}")

    print("\n## 手順1: 既存CIDRに包含される冗長な単一IP（挙動を変えず削除可）")
    redundant = set()
    for ip in sorted(singles, key=lambda x: ipaddress.ip_address(x)):
        hit = next((n for n in nets if ipaddress.ip_address(ip) in n), None)
        if hit:
            redundant.add(ip)
            print(f"  {ip:18s} ⊂ {hit}  servers={sorted(singles[ip])}")
    print(f"  -> {len(redundant)} 件")

    print("\n## 手順2: /24バケット（2件以上 = 統合候補）")
    buckets = collections.defaultdict(list)
    for ip in singles:
        if ip in redundant:
            continue
        buckets[str(net(ip + "/24"))].append(ip)
    n_cand = 0
    for b in sorted(buckets, key=sort_key):
        ips = sorted(buckets[b], key=lambda x: ipaddress.ip_address(x))
        if len(ips) >= 2:
            n_cand += 1
            srv = sorted(set().union(*[singles[i] for i in ips]))
            print(f"  {b:18s} ({len(ips)}件) {ips}  servers={srv}")
    print(f"  -> 統合候補バケット {n_cand} 個")

    print("\n## サーバ間で重複している単一IP")
    dup = sorted([i for i in singles if len(singles[i]) > 1],
                 key=lambda x: ipaddress.ip_address(x))
    for ip in dup:
        print(f"  {ip:18s} servers={sorted(singles[ip])}")
    print(f"  -> {len(dup)} 件")

    if args.dump_ips:
        with open(args.dump_ips, "w", encoding="utf-8", newline="\n") as f:
            for ip in sorted(singles, key=lambda x: ipaddress.ip_address(x)):
                f.write(ip + "\n")
        print(f"\nユニーク単一IP {len(singles)} 件を {args.dump_ips} に書き出し "
              f"(rdap_lookup.py --file に渡す)")


def load_rdap(path):
    rd = {}
    for line in read_text(path).splitlines():
        p = line.split("\t")
        if len(p) >= 2:
            rd[p[0]] = (p[1], p[2] if len(p) >= 3 else "")
    return rd


def cmd_hotblocks(args):
    singles, _ = parse_files(args.files)
    rd = load_rdap(args.rdap)
    groups = collections.defaultdict(list)
    for ip in singles:
        cidr, org = rd.get(ip, ("?", ""))
        groups[(cidr, org)].append(ip)

    hot = [(c, o, ips) for (c, o), ips in groups.items() if len(ips) >= args.min]
    hot.sort(key=lambda x: -len(x[2]))
    print(f"# 登録ブロックに個別IPが {args.min} 件以上入っているもの ({len(hot)} 件)")
    for cidr, org, ips in hot:
        ips = sorted(ips, key=lambda x: ipaddress.ip_address(x))
        sup = supernet(ips)
        tier = "広げない(ハイパースケーラ)" if HYPER.search(org) else "要検討"
        print(f"\n● {org}  [{tier}]  {len(ips)}件")
        print(f"   登録ブロック(RDAP): {cidr}")
        print(f"   全件を覆う最小CIDR: {sup} ({sup.num_addresses:,} アドレス)")
        print(f"   IP: {ips}")
    print("\n注意: 登録が複数CIDRに分割(タイル化)されている場合、"
          "RDAP が返す最大の構成ブロックが対象IPを覆うとは限らない。")
    print("適用するCIDRは必ず `check` で包含を検証すること。")


def cmd_check(args):
    singles, _ = parse_files(args.files)
    ips = sorted(singles, key=lambda x: ipaddress.ip_address(x))
    print("# 包含検証: 指定CIDRが実際にどの単一IPを覆うか")
    for c in args.cidr:
        n = net(c)
        inside = [ip for ip in ips if ipaddress.ip_address(ip) in n]
        print(f"\n{c}  ({n.num_addresses:,} アドレス)")
        print(f"  覆う {len(inside)} 件: {inside}")


def cmd_build(args):
    singles, cidrs = parse_files(args.files)
    add = [a.strip() for a in ",".join(args.add).split(",") if a.strip()] if args.add else []
    final_cidrs = set(cidrs) | set(add)
    final_nets = [net(c) for c in final_cidrs]
    kept, removed = [], collections.defaultdict(list)
    for ip in singles:
        hit = next((n for n in final_nets if ipaddress.ip_address(ip) in n), None)
        if hit:
            removed[str(hit)].append(ip)
        else:
            kept.append(ip)
    entries = sorted(kept + list(final_cidrs), key=sort_key)
    with open(args.out, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(entries) + "\n")
    print(f"{args.out}: {len(entries)} エントリ (単一IP {len(kept)} + CIDR {len(final_cidrs)})")
    for c in sorted(removed, key=sort_key):
        print(f"  {c} が吸収/削除: {len(removed[c])} 件")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("analyze"); p.add_argument("files", nargs="+")
    p.add_argument("--dump-ips"); p.set_defaults(func=cmd_analyze)

    p = sub.add_parser("hotblocks"); p.add_argument("files", nargs="+")
    p.add_argument("--rdap", required=True); p.add_argument("--min", type=int, default=5)
    p.set_defaults(func=cmd_hotblocks)

    p = sub.add_parser("check"); p.add_argument("files", nargs="+")
    p.add_argument("--cidr", action="append", required=True); p.set_defaults(func=cmd_check)

    p = sub.add_parser("build"); p.add_argument("files", nargs="+")
    p.add_argument("--add", action="append"); p.add_argument("-o", "--out", required=True)
    p.set_defaults(func=cmd_build)

    args = ap.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
