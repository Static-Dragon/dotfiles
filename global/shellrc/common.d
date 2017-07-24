#=======================
# Shell-common
# Maintained by Justin Doyle
# Last edited: November 13th, 2016
#=======================

# Tmux start {{{

# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
#	test -z "$TMUX" && (tmux attach || tmux new-session)
fi


# }}}

# Environment Variables {{{

if [[ -n "$ZSH_VERSION" ]]; then
	export HISTFILE=$HOME/.config/zsh/history
else
	export HISTFILE=$HOME/.config/bash/bash-history
fi
if hash nvim 2>/dev/null;then
	export EDITOR=nvim
elif hash vim 2>/dev/null; then
	export EDITOR=vim
elif hash emacs 2>/dev/null;then
	export EDITOR=emacs
elif hash nano 2>/dev/null; then
	export EDITOR=nano
elif hash nano-tiny 2>/dev/null; then
	export EDITOR=nano-tiny
else
	export EDITOR=vi
fi

if hash mpv 2>/dev/null; then
	VIDEO=mpv
elif hash mplayer 2>/dev/null; then
	VIDEO=mplayer
fi

if hash cmus 2>/dev/null; then
	MUSIC=cmus
elif hash mplayer 2>/dev/null; then
	MUSIC=mplayer
elif hash mpv 2>/dev/null; then
	MUSIC="mpv --no-video"
fi


if [ -d /run/openrc ]; then
	INIT=openrc
else
	INIT=systemd
fi

export SHELLEX=/etc/shell-extensions
export VISUAL=$EDITOR
export PAGER=less
export SVRIP=192.168.1.81 # Change if applicable
# Shutdown/reboot

if [ $UID -ne 0 ]; then
	alias reboot="sudo reboot"
	alias shutdown="sudo poweroff"
fi

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



#if hash wine 2>/dev/null; then
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
