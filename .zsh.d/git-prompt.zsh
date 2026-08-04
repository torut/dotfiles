# Show branch name in Zsh's right prompt
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
setopt prompt_subst

defaultPrompt=`echo $PROMPT`

autoload -Uz add-zsh-hook
function rprompt-git-current-branch {
	PROMPT="$defaultPrompt"

    local name gitdir action
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

	PROMPT="[$name$action]%E
$defaultPrompt"
}

add-zsh-hook precmd rprompt-git-current-branch
