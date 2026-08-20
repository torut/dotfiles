#!/bin/bash
# tmuxのウィンドウ状態表示(window-status-format)向けに、
# Claude Codeが入力待ちかどうかを window-scoped user option @claude_waiting に反映する。
set -euo pipefail

state="${1:-1}"

if [[ -z "${TMUX_PANE:-}" ]]; then
  exit 0
fi

tmux set-window-option -t "$TMUX_PANE" "@claude_waiting" "$state" 2>/dev/null || true

exit 0
