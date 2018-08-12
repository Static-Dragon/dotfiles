#!/bin/sh
#=======================
# Shell-aliases
# Maintained by Justin "static-dragon" Doyle
# Last edited: August 12th, 2018
#=======================

# Alias Declaration {{{

#  File manipulation {{{


if command -v startx >/dev/null; then
	alias xinit="$EDITOR ~/.xinitrc"
	alias xres="$EDITOR ~/.Xresources"
fi

# Distro-specific {{{

# Arch {{{
if [[ $DIST = *"Arch"* ]]; then
    # Files {{{
        alias pmedit="sued $EDITOR /etc/pacman.d/mirrorlist"
        alias pconf="sued $EDITOR /etc/pacman.conf"
        if command -v abs >/dev/null; then
            alias absconf="sued /etc/abs.conf"
            alias makepkg="sued /etc/makepkg.conf"
        fi
    #}}}
    # Package mgmnt {{{
	if [[ $UID -ne 0 ]]; then
		if command -v pacmatic >/dev/null; then
			alias spacman="sudo pacmatic"
		elif command -v powerpill >/dev/null; then
			alias spacman="sudo powerpill"
		else
			alias spacman="sudo pacman"
		fi
fi
	alias paci="spacman -S"
	alias lspaci="pacman -Qe > /tmp/pkgs && less /tmp/pkgs && rm -f /tmp/pkgs"
	alias pacr="spacman -R"
	alias pacs="pacman -Ss"
	alias pacsi="pacman -Qs"
	alias pacc="pacman -Sc"
	alias mkpkg="makepkg -si"
	if command -v yaourt >/dev/null; then
		alias auri="yaourt -S"
		alias aurs="yaourt"
		alias aurr="yaourt -R"
		alias pacu="yaourt -Syua"
	elif command -v pacaur >/dev/null; then
		alias auri="pacaur -Sa"
		alias aurs="pacaur -s"
		alias aurr="pacaur -R"
		alias pacu="pacaur -Syu"
	elif command -v aurman >/dev/null; then
#		alias aurman="aurman --color "
		alias auri="aurman -S"
		alias aurs="aurman -Ss"
		alias aurr="aurman -R"
		alias pacu="aurman -Syu"
	else
		alias pacu="spacman -Syu"
		alias auri=""
	fi
	alias update="pacu"
    #}}}
# }}}

# Debian\*buntu\mint {{{
elif [[ $DIST = *"Debian"* ]]; then
	alias asedit="sued $EDITOR /etc/apt/sources.list"
	aptpref="apt"
	if [[ $UID -ne 0 ]]; then
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
	alias update="aptu"
# }}}

# Gentoo {{{
elif [[ $DIST = *"Gentoo"* ]]; then
	alias portpak="sued $EDITOR /etc/portage/package.accept_keywords"
	if [[ ! -d /etc/package.use ]]; then
		alias portuse="sued $EDITOR /etc/portage/package.use"
	else
		alias portuse="cd /etc/portage/package.use"
	fi
	alias portmask="sued $EDITOR /etc/portage/package.mask"
	alias portumask="sued $EDITOR /etc/portage/package.unmask"
	alias makeconf="sued $EDITOR /etc/portage/make.conf"
	alias confup="sudo dispatch-conf"
	if [[ $UID -ne 0 ]]; then
		alias geni="sudo emerge"
	else
		alias geni="emerge"
	fi
	alias gens="geni --search"
	alias genr="geni -cav"
	alias genu="geni -uDU --with-bdeps=y @world"
	alias genuse-desc="euse -i"
	if command -v equery >/dev/null; then
		if [[ $UID -ne 0 ]]; then
			alias genuse="sudo equery uses"
		else
			alias genuse="equery uses"
		fi
	fi
	if command -v layman >/dev/null; then
		if [[ $UID -ne 0 ]]; then
			alias slay="sudo layman"
		else
			alias slay="layman"
		fi
		alias laya="slay -a"
		alias layr="slay -d"
		alias layl="slay -l"
	fi
	if command -v pacman >/dev/null; then
		if [[ $UID -ne 0 ]]; then
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
	# portage args (Honestly, this one seemed kinda stupid)
	# alias awr="--autounmask-write"
	alias update="genu"
elif [[ $DIST = *"Fedora"* ]]; then
	if command -v dnf >/dev/null; then
		if [[ $UID -ne 0 ]]; then
			alias dnfs="sudo dnf"
		else
			alias dnfs="dnf"
		fi
	else
		if [[ $UID -ne 0 ]]; then
			alias dnfs="sudo yum"
		else
			alias dnfs="yum"
		fi
	fi
	alias fedi="dnfs install"
	alias fedr="dnfs remove"
	alias fedure="dnfs copr enable"
	alias fedurd="dnfs copr disable"
	alias feds="dnfs search"
	alias fedu="dnfs update"
	alias update="fedu"
elif [[ $DIST = *"openSUSE"* ]]; then
    alias z='sudo zypper' #call zypper
    alias zh='sudo zypper -h' #print help
    alias zhse='sudo zypper -h se' #print help for the search command
    alias zlicenses='sudo zypper licenses' #prints a report about licenses and EULAs of installed packages
    alias zps='sudo zypper ps' #list process using deleted files
    alias zshell='sudo zypper shell' #open a zypper shell session
    alias zsource-download='sudo zypper source-download' #download source rpms for all installed packages
    alias ztos='sudo zypper tos' #shows  the  ID string of the target operating system
    alias zvcmp='sudo zypper vcmp' #tell whether version1 is older or newer than version2
    alias zin='sudo zypper in' #install packages
    alias zinr='sudo zypper inr' #install newly added packages recommended by already installed ones
    alias zrm='sudo zypper rm' #remove packages
    alias zsi='sudo zypper si' #install source of a package
    alias zve='sudo zypper ve' #verify dependencies of installed packages
    alias zdup='sudo zypper dup' #upgrade packages
    alias zlp='sudo zypper lp' #list necessary patchs
    alias zlu='sudo zypper lu' #list updates
    alias zpchk='sudo zypper pchk' #check for patches
    alias zup='sudo zypper up' #update packages
    alias zpatch='sudo zypper patch' #install patches
    alias zal='sudo zypper al' #add a package lock
    alias zcl='sudo zypper cl' #Remove unused locks
    alias zll='sudo zypper ll' #list currently active package locks
    alias zrl='sudo zypper rl' #remove specified package lock
fi
# }}}

# }}}

# desktop environment/WM configs {{{

if command -v i3 >/dev/null; then
	alias i3edit="$EDITOR ~/.config/i3/config"
	alias i3bedit="$EDITOR /etc/i3status.conf"
fi

if command -v openbox >/dev/null; then
	alias obaedit="$EDITOR ~/.config/openbox/autostart"
fi

if command -v feh >/dev/null; then
	alias randombg="feh --randomize --bg-fill ~/Pictures/wallpapers/"
fi

# }}}

# Misc {{{

alias aliases="$PAGER ~/.bashrc"
alias hosts="$PAGER /etc/hosts"
alias leafpad="GTK2_RC_FILES=/usr/share/themes/Arc-Darker/gtk-2.0/gtkrc leafpad"


# }}}

#}}}

# Command Shortening {{{

# Vim-like aliases {{{

alias :q="exit" # vim-like quit
alias :e="$EDITOR"
alias :d="rm"


# }}}


# init related {{{

# Systemd {{{
if [[ $INIT == 'systemd' ]]; then
	if [[ $UID -ne 0 ]]; then
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
	alias shutdown="systemctl poweroff"
	alias reboot="systemctl reboot"
#}}}

# Openrc {{{
elif [[ $INIT == 'openrc'  ]]; then
	if [[ $UID -ne 0 ]]; then
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

if [[ $UID -ne 0  ]]; then
	alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
	alias grub-install="sudo grub-install /dev/sda"
else
	alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
	alias grub-install="sudo grub-install /dev/sda"
fi

#}}}

# }}}

# Code Compilation {{{

if command -v javac >/dev/null; then
	alias jc="javac"
	alias jar="java --jar"
fi

# }}}

# General stuff {{{

alias c="tput clear"
alias cls="tput clear"
alias lspcia="lspci -vt"
alias lsusba="lsusb -vt"
alias lessa="less -R"
alias lsblka="lsblk --output NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT,UUID"
alias lsblkb="lsblk --output STATE,SERIAL,NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT,UUID"

if command -v rg >/dev/null; then
	alias grep="rg"
fi

if command -v nemo >/dev/null; then
	alias nemo="nemo --no-desktop"
fi

if command -v lxlogout >/dev/null; then
	if [[ -f ~/.rotator ]]; then
		alias lxlogout='killall -9 .rotator | exit 0 && lxsession-logout'
	fi
fi

if [[ $UID -ne 0 ]]; then
	if command -v scrot >/dev/null; then
		if [[ -d ~/Pictures/screenshots  ]]; then	
			alias scrot="scrot && mv *.png ~/Pictures/screenshots/"
		else
			mkdir ~/Pictures/screenshots
			alias scrot="scrot && mv *.png ~/Pictures/screenshots"
		fi
		if command -v screenfetch >/dev/null; then
			alias screenfetch="screenfetch && sleep .5 && scrot"
		elif command -v neofetch >/dev/null; then
			alias neofetch="neofetch -c ~/.config/neofetch/config"
			alias neofetchs="neofetch -c ~/.config/neofetch/config -s  "
			alias neofetchl="echo "" && vrms && echo "" && neofetch -c ~/.config/neofetch/config -s"
		fi
	fi
	if command -v beep >/dev/null; then
		alias beep="sudo beep"
	fi
	alias visudo="sudo visudo"
	if command -v htop >/dev/null; then
		alias htop="sudo htop"
		alias top="htop"
	fi
	if command -v testdisk >/dev/null; then
		alias td="sudo testdisk"
	fi
	alias sued="sudo -E"
	if command -v vim >/dev/null; then
		alias svim="sued vim"
	fi
	alias mnt="sudo mount"
	alias umnt="sudo umount"
else
	if command -v htop >/dev/null; then
		alias top="htop"
	fi
	if command -v testdisk >/dev/null; then
		alias td="testdisk"
	fi
	alias mnt="mount"
	alias umnt="umount"
fi

if command -v ncdu >/dev/null; then
	alias du="ncdu"
fi

if command -v pydf >/dev/null; then
	alias df="pydf"
else
	alias df="df -THx tmpfs"
fi
alias mpvm="mpv --no-video" #Mpv music

# alias clear='reset'  #Not an ideal solution
alias clear='printf "\033c"' #Make clear actually clear console

alias server.connect="ssh user@$SVRIP"

if command -v vim >/dev/null; then
	alias vi="vim"
elif command -v nvim >/dev/null; then
	alias vi="nvim"
fi

alias hg="history | grep $1" #search through bash history, and match user input
alias mv="mv -i -v" #Ask if you want to move a file/folder and verbosely do it
alias rm="rm -i -v --preserve-root" #rm sanity check, w/ verbosity
alias chmod="chmod -v --preserve-root" #ditto for chmod
alias chown="chown -v --preserve-root" #ditto for chown
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
alias la="ls -lash --color"
alias ls="ls -lsh --color"
alias dir='ls'
if command -v rsync >/dev/null; then
	alias cp="rsync -rv --progress"
	alias mv="rsync -aP --remove-source-files"
fi
# alias cd="cd $1 && ls" Doesn't work, needs to be function

# Clear tmp directory

if [[ $UID -ne 0 ]]; then
	alias clrtmp="sudo -rf /tmp/*"
else
	alias clrtmp="rm -rf /tmp/*"
fi

# }}}

# Git-Related {{{

#=====================
# Git related
#=====================

if command -v git >/dev/null; then
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
	alias gitu='(for l in `find . -name .git | xargs -i dirname {}` ; do cd $l; pwd; git pull; cd -; done) >/dev/null' #Update all git repos on system

fi

# }}}

# Fun Stuff {{{

#=====================
# Fun stuff
#=====================


#if command -v telnet >/dev/null; then
#	alias sw="telnet towel.blinkenlights.nl"
#fi

# }}}
