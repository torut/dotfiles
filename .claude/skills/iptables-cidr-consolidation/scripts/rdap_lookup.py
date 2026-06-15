#!/usr/bin/env python3
"""RDAP lookups for a batch of IPs, robust against rate limits.

whois is often not installed on Windows/minimal hosts, so this uses RDAP over
HTTPS (the modern whois replacement) via stdlib only -- no pip install needed.

It queries the rdap.org bootstrap, which redirects to the correct RIR. A first
concurrent pass is fast but rdap.org rate-limits (HTTP 429) and the bootstrap
occasionally resets connections, so failures are retried sequentially with
backoff. That two-phase approach is what reliably gets a full result set.

Usage:
    python rdap_lookup.py 1.2.3.4 5.6.7.8 ...
    python rdap_lookup.py --file ips.txt          # one IP/CIDR per line
    cat ips.txt | python rdap_lookup.py            # from stdin
    python rdap_lookup.py --file ips.txt --json    # JSON instead of TSV

Output (TSV by default): IP<TAB>allocated_cidr<TAB>org
The "allocated_cidr" is the RIR registration block for that IP, which for cloud
providers is often huge (e.g. 20.0.0.0/11) -- that is expected, and the caller
decides what is safe to actually block.
"""
import sys, json, argparse, urllib.request, concurrent.futures, time


def lookup(ip, timeout=30, attempts=1, base_sleep=0.0):
    """Return (cidr, org). On failure return ('ERROR:<reason>', '')."""
    last = ""
    for i in range(attempts):
        try:
            req = urllib.request.Request(
                "https://rdap.org/ip/" + ip,
                headers={"Accept": "application/json"},
            )
            with urllib.request.urlopen(req, timeout=timeout) as r:
                d = json.load(r)
            cidrs = [
                f"{c.get('v4prefix') or c.get('v6prefix')}/{c.get('length')}"
                for c in d.get("cidr0_cidrs", [])
            ]
            cidr = ",".join(cidrs) if cidrs else (
                f"{d.get('startAddress')}-{d.get('endAddress')}"
            )
            org = d.get("name") or d.get("handle") or "?"
            return cidr, org
        except Exception as e:  # noqa: BLE001 - want every failure mode retried
            last = str(e)[:60]
            if base_sleep:
                time.sleep(base_sleep * (i + 1))
    return "ERROR:" + last, ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("ips", nargs="*", help="IPs/CIDRs to look up")
    ap.add_argument("--file", help="file with one IP/CIDR per line")
    ap.add_argument("--json", action="store_true", help="emit JSON")
    ap.add_argument("--workers", type=int, default=4,
                    help="concurrency for first pass (keep low to avoid 429)")
    args = ap.parse_args()

    ips = list(args.ips)
    if args.file:
        with open(args.file) as f:
            ips += [ln.strip() for ln in f if ln.strip() and not ln.startswith("#")]
    if not ips and not sys.stdin.isatty():
        ips += [ln.strip() for ln in sys.stdin if ln.strip()]
    # dedupe, preserve order
    seen, ordered = set(), []
    for ip in ips:
        if ip not in seen:
            seen.add(ip)
            ordered.append(ip)
    if not ordered:
        ap.error("no IPs given (pass as args, --file, or stdin)")

    # Phase 1: fast concurrent pass.
    results = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(lookup, ip): ip for ip in ordered}
        for fut in concurrent.futures.as_completed(futs):
            results[futs[fut]] = fut.result()

    # Phase 2: retry the ones that failed, slowly and with backoff.
    failed = [ip for ip, (cidr, _) in results.items() if cidr.startswith("ERROR")]
    if failed:
        sys.stderr.write(f"retrying {len(failed)} failed lookup(s) slowly...\n")
        for ip in failed:
            results[ip] = lookup(ip, timeout=35, attempts=5, base_sleep=3.0)
            time.sleep(1.5)

    if args.json:
        out = [{"ip": ip, "cidr": results[ip][0], "org": results[ip][1]}
               for ip in ordered]
        print(json.dumps(out, indent=2))
    else:
        for ip in ordered:
            cidr, org = results[ip]
            print(f"{ip}\t{cidr}\t{org}")


if __name__ == "__main__":
    main()
