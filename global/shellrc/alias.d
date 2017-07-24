#=======================
# Shell-aliases
# Maintained by Justin Doyle
# Last edited: November 16th, 2016
#=======================

# Alias Declaration {{{

#  File manipulation {{{

#alias brcedit="$EDITOR ~/.bashrc && source ~/.bashrc Now a script in ~/Documents/scripts

if hash startx 2>/dev/null; then
	alias xinit="$EDITOR ~/.xinitrc"
	alias xres="$EDITOR ~/.Xresources"
fi

# Distro-specific {{{

# Arch {{{
if [[ -f /etc/arch-release ]]; then
	alias pmedit="sued $EDITOR /etc/pacman.d/mirrorlist"
	alias pconf="sued $EDITOR /etc/pacman.conf"
	if hash abs 2>/dev/null; then
		alias absconf="sued /etc/abs.conf"
		alias makepkg="sued /etc/makepkg.conf"
	fi
# }}}

# Debian/*buntu/mint {{{
elif [[ -f /etc/debian-release ]]; then
	alias asedit="sued $EDITOR /etc/apt/sources.list"
# }}}

# Gentoo {{{
elif [[ -f /etc/gentoo-release ]]; then
	alias portpak="sued $EDITOR /etc/portage/package.accept_keywords"
	if [[ ! -d /etc/package.use ]]; then
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
alias leafpad="GTK2_RC_FILES=/usr/share/themes/Arc-Darker/gtk-2.0/gtkrc leafpad"


# }}}

#}}}

# Command Shortening {{{

# Vim-like aliases {{{

alias :q="exit" # vim-like quit
alias :e="$EDITOR"
alias :d="rm"


# }}}

# Package-management related {{{

# Arch {{{
if [[ -f /etc/arch-release ]]; then
	if [[ $UID -ne 0 ]]; then
		if hash pacmatic 2>/dev/null; then
			alias spacman="sudo pacmatic"
		elif hash powerpill 2>/dev/null; then
			alias spacman="sudo powerpill"
		else
			alias spacman="sudo pacman"
		fi
	else
		if hash pacmatic 2>/dev/null; then
			alias spacman="pacmatic"
		elif hash powerpill 2>/dev/null; then
			alias spacman="powerpill"
		else
			alias spacman="pacman"
		fi
	fi
	alias paci="spacman -S"
	alias lspaci="pacman -Qe > /tmp/pkgs && less /tmp/pkgs && rm -f /tmp/pkgs"
	alias pacr="spacman -R" # Re-writing in shell script for a more robust command (no need, back to OG alias)
	alias pacs="pacman -Ss"
	alias pacsi="pacman -Qs"
	alias pacc="pacman -Sc"
	alias mkpkg="makepkg -si"
	#alias pacu="spacman -Syu" Merged into AUR-helper block
	if hash yaourt 2>/dev/null; then
		alias auri="yaourt -S"
		alias aurs="yaourt"
		alias aurr="yaourt -R"
		alias pacu="yaourt -Syua"
	elif hash pacaur 2>/dev/null; then
		alias auri="pacaur -Sa"
		alias aurs="pacaur -s"
		alias aurr="pacaur -R"
		alias pacu="pacaur -Syu"
	else
		alias pacu="spacman -Syu"
		alias auri=""
	fi
	alias update="pacu"

# }}}

# Debian/Ubuntu/Mint {{{
elif [[ -f /etc/debian-release ]]; then
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
elif [[ -f /etc/gentoo-release ]]; then
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
	if hash equery 2>/dev/null; then
		if [[ $UID -ne 0 ]]; then
			alias genuse="sudo equery uses"
		else
			alias genuse="equery uses"
		fi
	fi
	if hash layman 2>/dev/null; then
		if [[ $UID -ne 0 ]]; then
			alias slay="sudo layman"
		else
			alias slay="layman"
		fi
		alias laya="slay -a"
		alias layr="slay -d"
		alias layl="slay -l"
	fi
	if hash pacman 2>/dev/null; then
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

# }}}

 # Fedora {{{
elif [[ -f /etc/fedora-release  ]]; then
	if [[ $UID -ne 0 ]]; then
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
	alias update="fedu"
fi

#}}} 

#}}}

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

if hash javac 2>/dev/null; then
	alias jc="javac"
	alias jar="java --jar"
fi

# }}}

# General stuff {{{

alias c="clear"
alias cls="clear"
alias lspcia="lspci -vt"
alias lsusba="lsusb -vt"
alias lessa="less -R"
alias lsblka="lsblk --output NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT,UUID"
alias lsblkb="lsblk --output STATE,SERIAL,NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT,UUID"

if hash rg 2>/dev/null; then
	alias grep="rg"
fi

if hash nemo 2>/dev/null; then
	alias nemo="nemo --no-desktop"
fi

if hash lxlogout 2>/dev/null; then
	if [[ -f ~/.rotator ]]; then
		alias lxlogout='killall -9 .rotator | exit 0 && lxsession-logout'
	fi
fi

if [[ $UID -ne 0 ]]; then
	if hash scrot 2>/dev/null; then
		if [[ -d ~/Pictures/screenshots  ]]; then	
			alias scrot="scrot && mv *.png ~/Pictures/screenshots/"
		else
			mkdir ~/Pictures/screenshots
			alias scrot="scrot && mv *.png ~/Pictures/screenshots"
		fi
		if hash screenfetch 2>/dev/null; then
			alias screenfetch="screenfetch && sleep .5 && scrot"
		elif hash neofetch 2>/dev/null; then
			alias neofetch="neofetch -c ~/.config/neofetch/config"
			alias neofetchs="neofetch -c ~/.config/neofetch/config -s  "
			alias neofetchl="echo "" && vrms && echo "" && neofetch -c ~/.config/neofetch/config -s"
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
		alias svim="sued vim"
	fi
	alias mnt="sudo mount"
	alias umnt="sudo umount"
else
	if hash htop 2>/dev/null; then
		alias top="htop"
	fi
	if hash testdisk 2>/dev/null; then
		alias td="testdisk"
	fi
	alias mnt="mount"
	alias umnt="umount"
fi

if hash ncdu 2>/dev/null; then
	alias du="ncdu"
fi

if hash pydf 2>/dev/null; then
	alias df="pydf"
else
	alias df="df -THx tmpfs"
fi
alias mpvm="mpv --no-video" #Mpv music

# alias clear='reset'  #Not an ideal solution
alias clear='printf "\033c"' #Make clear actually clear console

alias server.connect="ssh user@$SVRIP"

if hash vim 2>/dev/null; then
	alias vi="vim"
elif hash nvim 2>/dev/null; then
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
if hash rsync 2>/dev/null; then
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
	alias gitu='(for l in `find . -name .git | xargs -i dirname {}` ; do cd $l; pwd; git pull; cd -; done) 2>/dev/null' #Update all git repos on system

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
