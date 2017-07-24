# Lines configured by zsh-newuser-install
export TERM="xterm-256color"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
# End of lines configured by zsh-newuser-install
#
#PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
#RPROMPT='[%F{yellow}%?%f]'
#source ~/.fonts/*.sh

if [ -d /etc/shellrc/zsh.d ]; then
	for file in /etc/shellrc/zsh.d/*.zsh; do
 		source $file
#		echo "hi"
	done
fi
if [ -d /etc/shellrc ]; then
	for file in /etc/shellrc/*; do
		source $file
	done
fi


# if the init scipt doesn't exist
if ! zgen saved; then
	#Load plugins
	#zgen load bhilburn/powerlevel9k powerlevel9k
	zgen load zsh-users/zsh-syntax-highlighting

	# generate the init script from plugins above
	zgen save
fi


