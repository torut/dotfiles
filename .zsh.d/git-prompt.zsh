# Show branch name in Zsh's right prompt
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
setopt prompt_subst
setopt re_match_pcre

defaultPrompt=`echo $PROMPT`
defaultRprompt=`echo $RPROMPT`

autoload -Uz add-zsh-hook
function rprompt-git-current-branch {
	PROMPT="$defaultPrompt"

    local name st color gitdir action
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi

    name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
    if [[ -z $name ]]; then
        return
    fi

	name="branch:$name"

    gitdir=`git rev-parse --git-dir 2> /dev/null`
	action=`VCS_INFO_git_getaction "$gitdir"`
	if [[ -n $action ]]; then
		action="|$action";
	fi

	# ステータスの状況によって色を変えたい場合は次の2行をコメントアウト
	PROMPT="[$name$action]%E
$defaultPrompt"
	return

    st=`git status 2> /dev/null`
	if [[ "$st" =~ "(?m)^nothing to" ]]; then
        color=%F{green}
	elif [[ "$st" =~ "(?m)^nothing added" ]]; then
        color=%F{yellow}
	elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi
    
	PROMPT="[$color$name$action%f%b]
$defaultPrompt"
}

add-zsh-hook precmd rprompt-git-current-branch
