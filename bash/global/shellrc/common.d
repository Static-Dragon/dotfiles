#!/bin/sh
#=======================
# Shell-common
# Maintained by Justin Doyle
# Last edited: September 5th, 2019
#=======================


# Environment Variables {{{

if command -v lsb_release >/dev/null; then
  DIST=$(lsb_release -ds | sed 's/^\"//g;s/\"$//g')
elif [ -f /etc/os-release ]; then
  source /etc/os-release
  if [ -n "${PRETTY_NAME}" ]; then
    DIST="${PRETTY_NAME}"
  else
    DIST="${NAME}"
#    [[ -n "${VERSION}" ]] && printf " ${VERSION}"
#    printf "\n"
  fi
# now looking at distro-specific files
elif [ -f /etc/arch-release ]; then
  DIST="Arch"
elif [ -f /etc/gentoo-release ]; then
  DIST="Gentoo"
elif [ -f /etc/fedora-release ]; then
  DIST="Fedora"
elif [ -f /etc/redhat-release ]; then
  DIST="RHEL"
elif [ -f /etc/debian_version ]; then
  DIST="Debian"
else
  DIST="Unkown"
fi

if [[ -n "$ZSH_VERSION" ]]; then
	export HISTFILE=$HOME/.config/zsh/history
else
	export HISTFILE=$HOME/.config/bash/bash-history
fi
if command -v nvim >/dev/null;then
	export EDITOR=nvim
elif command -v vim >/dev/null; then
	export EDITOR=vim
elif command -v emacs >/dev/null;then
	export EDITOR=emacs
elif command -v nano >/dev/null; then
	export EDITOR=nano
elif command -v nano-tiny >/dev/null; then
	export EDITOR=nano-tiny
else
	export EDITOR=vi
fi

if command -v mpv >/dev/null; then
	VIDEO=mpv
elif command -v mplayer >/dev/null; then
	VIDEO=mplayer
fi

if command -v cmus >/dev/null; then
	MUSIC=cmus
elif command -v mplayer >/dev/null; then
	MUSIC=mplayer
elif command -v mpv >/dev/null; then
	MUSIC="mpv --no-video"
fi


if [ -d /run/openrc ]; then
	INIT=openrc
else
	INIT=systemd
fi

if [ -d $HOME/Documents/Android/platform-tools ];then
	export PATH="$HOME/Documents/Android/platform-tools:$PATH"
fi

#if [ -d $HOME/Documents/scripts ]; then
#	source $HOME/Documents/scripts/*
#fi

export SHELLEX=/etc/shell-extensions
export VISUAL=$EDITOR
export PAGER=less
# Shutdown/reboot

if [ $UID -ne 0 ]; then
	alias reboot="sudo reboot"
	alias shutdown="sudo poweroff"
fi

# Colors
NC='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

# Less Settings

export LESSHISTFILE=$home/.config/lesshist
if [[ $PAGER == less ]]; then
	export LESSCHARSET='latin1'
# colored man pages
	export LESS_TERMCAP_mb=$'\E[01;31m'
	export LESS_TERMCAP_md=$'\E[01;31m'
	export LESS_TERMCAP_me=$'\E[0m'
	export LESS_TERMCAP_se=$'\E[0m'
	export LESS_TERMCAP_so=$'\E[01;44;33m'
	export LESS_TERMCAP_ue=$'\E[0m'
	export LESS_TERMCAP_us=$'\E[01;32m'
fi


# Useful settings for bash history

export HISTCONTROL=ignoredups #ignore duplicates in history
export HISTCONTROL=ignoreboth
export HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear:cls #ignore the following commands in history

if [[ -n "$BASH_VERSION" ]]; then

shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob         # pathname expansion will be treated as case-insensitive

[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh



#if command -v wine 2>/dev/null; then
#	export WINEARCH=win32
#fi

#if pgrep Xorg >/dev/null; then
#	xset -b 				# Disable console bell if X is running
#fi

# Autocomplete {{{

#=====================
# Autocomplete
#=====================

	# Compression
	complete -f -o default -X '*.+(zip|ZIP)'  zip
	complete -f -o default -X '!*.+(zip|ZIP)' unzip
	complete -f -o default -X '*.+(z|Z)'      compress
	complete -f -o default -X '!*.+(z|Z)'     uncompress
	complete -f -o default -X '*.+(gz|GZ)'    gzip
	complete -f -o default -X '!*.+(gz|GZ)'   gunzip
	complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
	complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
	complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract

#}}} 

#  PS1 Prompt {{{


# Non-powerline prompt{{{

export PS1="> \[$(tput sgr0)\]\[\033[38;5;50m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] @ [\[$(tput sgr0)\]\[\033[38;5;5m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\n\[$(tput sgr0)\]\[\033[38;5;40m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]"

fi

#}}}



# }}}

# }}}
