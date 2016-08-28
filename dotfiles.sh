#=================
# Justin T. Doyle
# Aug 27th, 2016
#================

# PURPOSE
# This is an automated installer for my dotfiles hosted on https://github.com/Static-Dragon/dotfiles it will check for installed pieces of software and install accordingly

alias cp="cp -v"

if [ hash i3 2>/dev/null -o hash i3-gaps 2>/dev/null ]; then
	if [ -d ~/.config/i3 ]; then
		cp -r ~/.config/i3 ~/.config/i3.bak
	fi
	cp -r i3 ~/.config
fi

if hash vim 2>/dev/null; then
	if [ -f ~/.vimrc ]; then
		cp ~/.vimrc ~/.vimrc.bak
	fi
	if [ -d ~/.vim ]; then
		cp -r ~/.vim ~/.vim.bak
	fi
	cp -r .vim ~/.vim
	cp .vimrc ~/.vimrc
fi

if hash zsh 2>/dev/null; then
	if [ -f ~/.zshrc ]; then
		cp ~/.zshrc ~/.zshrc.bak
	fi
	cp .zshrc ~/.zshrc
fi

if  [ -f ~/.bashrc ]; then
	cp ~/.bashrc ~/.bashrc.bak
fi
cp .bashrc ~/.bashrc

if [ -f ~/.vimrc ]; then
	cp ~/.vimrc ~/.vimrc.bak
fi
cp .vimrc ~/.vimrc

if [ -f ~/.Xresources ]; then
	cp ~/.Xresources ~/.Xresources.bak
fi
cp .Xresources ~/.Xresources

echo "Dotfiles sucessfully imported!"
