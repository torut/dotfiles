case "${TERM}" in
cons25)
  ;;
*)
  # if [ -x `which screen` ]; then
  #   screen -UR
  # fi
  if [ -x `which tmux` ]; then
    tmux ls
  fi
  ;;
esac

