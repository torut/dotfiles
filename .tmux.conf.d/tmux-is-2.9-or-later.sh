#!/bin/sh
# 現在のtmuxがバージョン2.9以上かどうかを判定する。
# .tmux.conf の if-shell から呼ばれる (tmux 1.8のような古いバージョンには
# if-shell の -F フラグが無いため、シェル側でバージョン比較する)。

v=$(tmux -V | sed -E 's/^tmux ([0-9]+)\.([0-9]+).*/\1 \2/')
major=$(echo "$v" | cut -d' ' -f1)
minor=$(echo "$v" | cut -d' ' -f2)

[ "$major" -gt 2 ] && exit 0
[ "$major" -eq 2 ] && [ "$minor" -ge 9 ] && exit 0
exit 1
