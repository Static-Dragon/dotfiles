#=======================
# ~/.zshrc
# Maintained by Justin Doyle
# Last edited: July 13th, 2016
#=======================

# Greeting {{{

#echo ""
#echo "Welcome, $USER!"
#echo ""
#\screenfetch

# }}}

# Colors! {{{

#BLACK='\e[0;30m'
#BLUE='\e[0;34m'
#GREEN='\e[0;32m'
#CYAN='\e[0;36m'
#RED='\e[0;31m'
#PURPLE='\e[0;35m'
#BROWN='\e[0;33m'
#LIGHTGRAY='\e[0;37m'
#DARKGRAY='\e[1;30m'
#LIGHTBLUE='\e[1;34m'
#LIGHTGREEN='\e[1;32m'
#LIGHTCYAN='\e[1;36m'
#LIGHTRED='\e[1;31m'
#LIGHTPURPLE='\e[1;35m'
#YELLOW='\e[1;33m'
#WHITE='\e[1;37m'

# }}}

# Environment Variables {{{

if hash vim 2>/dev/null; then
	export EDITOR=vim
elif hash nano 2>/dev/null; then
	export EDITOR=nano
elif hash nano-tiny 2>/dev/null; then
	export EDITOR=nano-tiny
else
	export EDITOR=vi
fi

if hash firefox 2>/dev/null; then
	if hash firejail 2>/dev/null; then
		export BROWSER=GTK_THEME=Arc-Darker firejail firefox
	else
		export BROWSER=firefox
	fi
fi

if [ -d /run/openrc ]; then
	INIT=openrc
else
	INIT=systemd
fi

export VISUAL=$EDITOR
export PAGER=less

# Shutdown/reboot

if [ $UID -ne 0 ]; then
	alias reboot="sudo reboot"
	alias shutdown="sudo poweroff"
fi

# }}}

# oh-my-zsh {{{

# Path to your oh-my-zsh installation.
export ZSH=/home/justin/.oh-my-zsh

ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

 HIST_STAMPS="mm/dd/yyyy"

plugins=(git
history
git-extras 
archlinux 
gnu-utils 
tmux 
vim-interaction 
zsh-navigation-tools 
cp 
colorize 
j-aliases   #My custom aliases
j-functions #My custom functions
)
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"
# }}}
