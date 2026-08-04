# set default editor and more.
export PATH=$PATH:$HOME/bin
export SVN_EDITOR="emacs -nw"
export EDITOR="emacs -nw"
export PAGER=less
export LESSCHARSET=utf-8

if [[ -x `whence -p lv` ]]; then
	export PAGER="lv -c"
fi
