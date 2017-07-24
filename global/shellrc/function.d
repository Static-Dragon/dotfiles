#=======================
# Shell-functions
# Maintained by Justin Doyle
# Last edited: November 13th, 2016
#=======================


# Function Declaration {{{ 

# ls {{{

#function ls () {
#	ls -lsh --color | awk {'print $4" "$7" "$8" "$9" "$10'}
#}

###  }}}
 
# extract {{{

# Runs command based on file extension of compressed file

extract () {
   if [[ -f $1 ]] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
		   *.lrz) 		lrunzip $1 	   ;;
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


# Umountiso {{{

#unmount all isos

umountiso () {
	mountpoint -q /mnt
	MNT1=$?
	mountpoint -q /mnt2
	MNT2=$?

	if [[ $MNT2 = "0" ]]; then
		sudo umount /mnt2
		umountiso
	elif [[ $MNT1 = "0" ]]; then
		sudo umount /mnt
	else
		echo "no ISOs are mounted"
	fi

}

#}}}

# myip {{{

#Find your current IP (Assuming you're connected to the internet

if hash lynx 2>/dev/null; then
	myip () {
		lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
	}
fi

# }}}

# MPV Youtube Music {{{

# Play music from youtube via MPV
function mm() {
	if hash mpv 2>/dev/null; then
		if hash youtube-dl 2>/dev/null; then
				mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
		else
			echo "you need youtube-dl to run this command"
		fi
	fi
}

# }}}

# Twitch {{{

# Watch twitch streams via MPV

function twitch() {
	if hash mpv 2>/dev/null; then
		if hash livestreamer 2>/dev/null; then
			livestreamer -p $VIDEO twitch.tv/$@ source &
		else
			echo "You need livestreamer to run this command"
		fi
	fi
}
# }}}

# Weather {{{

function weather () {
	curl -k "https://wttr.in/"
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

 # }}}
