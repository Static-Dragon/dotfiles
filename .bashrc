#=======================
# ~/.bashrc
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

# Tmux start {{{

#if which tmux >/dev/null 2>&1; then
	#if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || tmux new-session)
#fi

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

# Less Settings

if [ $PAGER == less ]; then
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
:
export HISTCONTROL=ignoredups #ignore duplicates in history
export HISTCONTROL=ignoreboth
export HISTIGNORE=ls:ll:la:l:cd:pwd:exit:mc:su:df:clear:cls #ignore the following commands in history

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


if hash wine 2>/dev/null; then
	export WINEARCH=win32
fi

# Enable command not found if it exists

[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh



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

# PS1 Prompt {{{

if hash bash 2>/dev/null; then

	export PS1="> \[$(tput sgr0)\]\[\033[38;5;50m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] @ [\[$(tput sgr0)\]\[\033[38;5;5m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\n\[$(tput sgr0)\]\[\033[38;5;40m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]"

fi

# }}}

# }}}

# Alias Declaration {{{

#  File manipulation {{{

#alias brcedit="$EDITOR ~/.bashrc && source ~/.bashrc Now a script in ~/Documents/scripts

if hash startx 2>/dev/null; then
	alias xinit="$EDITOR ~/.xinitrc"
	alias xres="$EDITOR ~/.Xresources"
fi

#if hash vim 2>/dev/null; then
	#alias vrcedit="$EDITOR ~/.vimrc" Now a script in ~/Documents/scripts, it has more functionallity
#fi

# Distro-specific {{{

# Arch {{{
if [ -f /etc/arch-release ]; then
	alias pmedit="sued $EDITOR /etc/pacman.d/mirrorlist"
	alias pconf="sued $EDITOR /etc/pacman.conf"
# }}}

# Debian/*buntu/mint {{{
elif [ -f /etc/debian-release ]; then
	alias asedit="sued $EDITOR /etc/apt/sources.list"
# }}}

# Gentoo {{{
elif [ -f /etc/gentoo-release ]; then
	alias portpak="sued $EDITOR /etc/portage/package.accept_keywords"
	if [ ! -d /etc/package.use ]; then
		alias portuse="sued $EDITOR /etc/portage/package.use"
	else
		alias portuse="cd /etc/portage/package.use"
	fi
	alias portmask="sued $EDITOR /etc/portage/package.mask"
	alias portumask="sued $EDITOR /etc/portage/package.unmask"
	alias makeconf="sued $EDITOR /etc/portage/make.conf"
fi
# }}}

# }}}

# desktop environment/WM configs {{{

if hash i3 2>/dev/null; then
	alias i3edit="$EDITOR ~/.config/i3/config"
	alias i3bedit="$EDITOR /etc/i3status.conf"
fi

if hash openbox 2>/dev/null; then
	alias obaedit="$EDITOR ~/.config/openbox/autostart"
fi

if hash feh 2>/dev/null; then
	alias randombg="feh --randomize --bg-fill ~/Pictures/wallpapers/"
fi

# }}}

# Misc {{{

alias aliases="$PAGER ~/.bashrc"
alias hosts="$PAGER /etc/hosts"

# }}}

#}}}

# Command Shortening {{{

# Package-management related {{{

# Arch {{{
if [ -f /etc/arch-release ] ; then
	if [ $UID -ne 0 ]; then
		alias spacman="sudo pacman"
	else
		alias spacman="pacman"
	fi
	alias paci="spacman -S"
	alias pacr="spacman -R" # Re-writing in shell script for a more robust command (no need, back to OG alias)
	alias pacs="pacman -Ss"
	alias pacsi="pacman -Qs"
	alias pacc="pacman -Sc"
	alias pacu="spacman -Syu"
	if hash yaourt 2>/dev/null; then
		alias auri="yaourt -S"
		alias aurs="yaourt"
		alias aurr="yaourt -R"
	fi

# }}}

# Debian/*buntu/Mint {{{
elif [ -f /etc/debian-release ]; then
	aptpref="apt-get"
	if [ $UID -ne 0 ]; then
		alias sag="sudo $aptpref"
	else
		alias sag="$aptpref"
	fi
	alias apti="sag install"
	alias aptr="sag remove"
	alias apts="apt-cache search"
	alias aptp="sag purge"
	alias aptps="sudo dpkg --get-selections | grep 'deinstall'"
	alias aptpr="aptp $(sudo dpkg --get-selections | grep 'deinstall' | cut -f1)"
	alias aptu="sag update && sag dist-upgrade"
# }}}

# Gentoo {{{
elif [ -f /etc/gentoo-release ]; then
	alias confup="sudo dispatch-conf"
	if [ $UID -ne 0 ]; then
		alias geni="sudo emerge"
	else
		alias geni="emerge"
	fi
	alias gens="geni --search"
	alias genr="geni -cav"
	alias genu="geni -uDU --with-bdeps=y @world"
	alias genuse-desc="euse -i"
	if hash equery 2>/dev/null; then
		if [ $UID -ne 0 ]; then
			alias genuse="sudo equery uses"
		else
			alias genuse="equery uses"
		fi
	fi
	if hash layman 2>/dev/null; then
		if [ $UID -ne 0 ]; then
			alias slay="sudo layman"
		else
			alias slay="layman"
		fi
		alias laya="slay -a"
		alias layr="slay -d"
		alias layl="slay -l"
	fi
	if hash pacman 2>/dev/null; then
		if [ $UID -ne 0 ]; then
			alias spacman="sudo pacman"
		else
			alias spacman="pacman"
		fi
		alias paci="spacman -S"
		alias pacr="spacman -R" # Re-writing in shell script for a more robust command (no need, back to OG alias)
		alias pacs="pacman -Ss"
		alias pacsi="pacman -Qs"
		alias pacc="pacman -Sc"
		alias pacu="spacman -Syu"
	fi
	# portage args
	alias awr="--autounmask-write"

# }}}

 # Fedora {{{
elif [ -f /etc/fedora-release  ]; then
	if [ $UID -ne 0 ]; then
		alias dnfs="sudo dnf"
	else
		alias dnfs="sudo dnf"
	fi
	alias fedi="dnfs install"
	alias fedr="dnfs remove"
	alias fedure="dnfs copr enable"
	alias fedurd="dnfs copr disable"
	alias feds="dnfs search"
	alias fedu="dnfs update"
fi

#}}} 

#}}}

# init related {{{

# Systemd {{{
if [ $INIT == 'systemd' ]; then
	if [ $UID -ne 0 ]; then
		alias ssystemctl="sudo systemctl"
	else
		alias ssystemctl="systemctl"
	fi
	alias sysde="ssystemctl enable"
	alias sysdd="ssystemctl disable"
	alias sysdre="ssystemctl restart"
	alias sysdrel="ssystemctl reload"
	alias sysdstat="systemctl status"
	alias lssysd="systemctl list-units"
	alias lssysdf="lssysd | grep 'fail'"
	alias sysdjo="journalctl"
	alias sysdjof="journalctl | grep 'fail'"
#}}}

# Openrc {{{
elif [ $INIT == 'openrc'  ]; then
	if [ $UID -ne 0 ]; then
		alias srcu="sudo rc-update"
		alias srcs="sudo rc-service" 
		alias rcstat="sudo rc-status"
	else
		alias srcu="rc-update"
		alias srcs="rc-service"
		alias rcstat="rc-status"
	fi
	alias rcadd="srcu add $1 default"
	alias rcstart="srcs $1 start"
fi
# }}}

# }}}

# Bootloader related {{{

# GRUB {{{ 

if [ $UID -ne 0  ]; then
	alias update-grub="sudo grub2-mkconfig -o /boot/grub2/grub.cfg"
	alias grub-install="sudo grub-install /dev/sda"
else
	alias update-grub="sudo grub2-mkconfig -o /boot/grub2/grub.cfg"
	alias grub-install="sudo grub-install /dev/sda"
fi

#}}}

# }}}

# Code Compilation {{{

if hash javac 2>/dev/null; then
	alias jc="javac"
	alias jar="java --jar"
fi

# }}}

# General stuff {{{

alias c="clear"
alias cls="clear"
alias lspci="lspci -vt"
alias lsusb="lsusb -vt"
alias less="less -R"

if hash nemo 2>/dev/null; then
	alias nemo="nemo --no-desktop"
fi

if [ $UID -ne 0 ]; then
	if hash scrot 2>/dev/null; then
		if [ -d ~/Pictures/screenshots  ]; then	
			alias scrot="scrot && mv *.png ~/Pictures/screenshots/"
		else
			mkdir ~/Pictures/screenshots
			alias scrot="scrot && mv *.png ~/Pictures/screenshots"
		fi
		if hash screenfetch 2>/dev/null; then
			alias screenfetch="screenfetch && sleep .5 && scrot"
		fi
		if hash neofetch 2>/dev/null; then
			alias neofetch="neofetch --ascii distro && sleep .5 && scrot"
		fi
	fi
	if hash beep 2>/dev/null; then
		alias beep="sudo beep"
	fi
	alias visudo="sudo visudo"
	if hash htop 2>/dev/null; then
		alias htop="sudo htop"
		alias top="htop"
	fi
	if hash testdisk 2>/dev/null; then
		alias td="sudo testdisk"
	fi
	alias sued="sudo -E"
	if hash vim 2>/dev/null; then
		alias svim="sudo vim"
	fi
else
	if hash htop 2>/dev/null; then
		alias top="htop"
	fi
	if hash testdisk 2/dev/null; then
		alias td="testdisk"
	fi
fi

if hash ncdu 2>/dev/null; then
	alias du="ncdu"
fi

if hash pydf 2>/dev/null; then
	alias df="pydf"
fi
alias mpvm="mpv --no-video" #Mpv music

# alias clear='reset'  #Not an ideal solution
alias clear='printf "\033c"' #Make clear actually clear console

if hash firejail 2>/dev/null; then
	if hash firefox 2>/dev/null; then
		alias firefox="GTK_THEME=Arc-Darker firejail firefox"
	fi
fi

alias vi="vim"
alias hg="history | grep $1" #search through bash history, and match user input
alias mv="mv -i -v" #Ask if you want to move a file/folder and verbosely do it
alias rm="rm -i -v --preserve-root" #rm sanity check, w/ verbosity
alias cp="cp -n -i -v" #Don't over-write files (learned this the hard way...)
# }}}

# Directory Control {{{

#=====================
# Directory Control
#=====================

alias home="cd ~/"
alias Downloads="cd ~/Downloads"
alias config="cd ~/.config"
alias l="command ls"
alias ls="ls -lAsh --group-directories-first --color"
alias dir='ls'
# alias cd="cd $1 && ls" Doesn't work, needs to be function

# Clear tmp directory

if [ $UID -ne 0 ]; then
	alias clrtmp="sudo -rf /tmp/*"
else
	alias clrtmp="rm -rf /tmp/*"
fi

# }}}

# Git-Related {{{

#=====================
# Git related
#=====================

if hash git 2>/dev/null; then
	alias gs='git status'
	alias gc='git commit'
	alias ga='git add'
	alias gd='git diff'
	alias gb='git branch'
	alias gl='git log'
	alias gsb='git show-branch'
	alias gco='git checkout'
	alias gg='git grep'
	alias gk='gitk --all'
	alias gr='git rebase'
	alias gri='git rebase --interactive'
	alias gcp='git cherry-pick'
	alias grm='git rm'
	alias gmk='git clone'
	alias gitupdate='(for l in `find . -name .git | xargs -i dirname {}` ; do cd $l; pwd; git pull; cd -; done) 2>/dev/null' #Update all git repos on system

fi

# }}}

# Fun Stuff {{{

#=====================
# Fun stuff
#=====================


if hash telnet 2>/dev/null; then
	alias sw="telnet towel.blinkenlights.nl"
fi

# }}}

# }}}

# }}} 

# Function Declaration {{{ 

# extract {{{

# Runs command based on file extension of compressed file

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# }}}

# up {{{

# Simple way to go up multiple directories

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# }}}

# Mountiso {{{

# mount an ISO file. (mountiso FILE)

mountiso () {
  name='basename "$1" .iso'
  mkdir /tmp/$name 2>/dev/null
  sudo mount -o loop "$1" "/tmp/$name"
  echo "mounted iso on /tmp/$name"
}

# }}}

# myip {{{

#Find your current IP (Assuming you're connected to the internet

myip () {
	lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
}

# }}}

# MPV Youtube Music {{{

# Play music from youtube via MPV

function mm() {
	mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
}

# }}}

# Twitch {{{

# Watch twitch streams via MPV

function twitch() {
	livestreamer -p mpv twitch.tv/$@ source &
}

# }}}

# Weather {{{

function weather () {
	curl -k "https://wttr.in/${l: -Palm Bay FL}"
}

# }}}

# MCD {{{

function mcd() {
	mkdir -p $1
	cd $1
}

# }}}

# compress {{{

#create tar.gz archive

function compress() {
	tar -cvzf $1 $2
}

# }}}

# Scripts {{{

# Import scripts

if [ $UID -ne 0  ]; then 
	scripts=~/Documents/scripts
	if [ -d $scripts ] ; then
		files=( $scripts/*.sh )
		for i in ${files[@]}; do
			if [[ ! $i =~ "alias.sh" ]] && [[ ! $i =~ "wallpaper.sh" ]] && [[ ! $i =~ "randr.sh" ]] && [[ ! $i =~ "fixresolv.sh"  ]] && [[ ! $i =~ "gitrepo.sh" ]] ; then
				source $i
			fi
		done
	fi
fi

# }}}
