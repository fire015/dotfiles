export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Git Prompt
[[ -f "$HOME/dotfiles/.bash_prompt" ]] && source "$HOME/dotfiles/.bash_prompt"

finditphp() {
        find . -name "*.php" | xargs fgrep -l -i -e "$1"
}

startdocker() {
	STATUS=$(docker-machine status default)

	if [ "$STATUS" != "Running" ]
	then
		docker-machine start default
	fi

	eval $(docker-machine env default)
}

dockerssh() {
	startdocker
	ID=$(docker ps -f 'name=apache*' -q)

        if [ "$ID" != "" ]
        then
		docker exec -it $ID env TERM=xterm bash
	fi
}

alias fuphp=finditphp
alias ll='ls -al'
alias bt=startdocker
alias dosh=dockerssh
