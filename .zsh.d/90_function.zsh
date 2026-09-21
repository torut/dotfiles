## function configuration
#

# 今日の日付+キーワードのディレクトリを作成して移動
mkd() {
  if [[ -z "$1" ]]; then
    echo "usage: mkd <keyword>" >&2
    return 1
  fi
  local dir="$(date +%Y%m%d)-${1}"
  mkdir -p -- "$dir" && cd -- "$dir"
}
