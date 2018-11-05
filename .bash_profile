export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Git Prompt
[[ -f "$HOME/dotfiles/.bash_prompt" ]] && source "$HOME/dotfiles/.bash_prompt"

finditphp() {
        find . -name "*.php" | xargs fgrep -l -i -e "$1"
}

dockerssh() {
    ID=$(docker ps -f 'name=app' -q)

        if [ "$ID" != "" ]
        then
        docker exec -it $ID env TERM=xterm LINES=600 COLUMNS=100 bash
    fi
}

dockerlogs() {
        ID=$(docker ps -f 'name=app' -q)

        if [ "$ID" != "" ]
        then
                docker logs -f $ID
        fi
}

kubeproxy() {
	while true; do
		read -p "Production (y) or Non-Production (n)? " yn
		case $yn in
			[Yy]* ) export KUBECONFIG=$HOME/.ssh/kops-prod-kubeconfig; break;;
			[Nn]* ) export KUBECONFIG=$HOME/.ssh/kops-nonprod-kubeconfig; break;;
			* ) echo "Please answer yes or no.";;
		esac
	done	

	echo "http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"
	kubectl proxy
}

alias fuphp=finditphp
alias ll='ls -al'
alias dosh=dockerssh
alias dolg=dockerlogs
alias kubeproxy=kubeproxy
alias kubeprod='export KUBECONFIG=$HOME/.ssh/kops-prod-kubeconfig'
alias kubenonprod='export KUBECONFIG=$HOME/.ssh/kops-nonprod-kubeconfig'
