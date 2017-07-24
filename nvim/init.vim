" General VIM

let name = "Justin T. Doyle"

set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++ 	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab

set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	"	 Backspace behaviour

filetype indent on      " load filetype-specific indent files

set foldenable          " enable folding

set foldlevelstart=0   " open no folds by default

set foldnestmax=10      " 10 nested fold max
nnoremap <space> za	" open/close folds w/ space
set foldmethod=marker

" NeoBundle Scripts-----------------------------
if has('vim_starting')  
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
  set runtimepath+=~/.config/nvim/
endif

let neobundle_readme=expand('~/.config/nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)  
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.config/nvim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"
endif

call neobundle#begin(expand('$HOME/.config/nvim/bundle'))  
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'vim-scripts/closetag.vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tmhedberg/matchit'
call neobundle#end()  
filetype plugin indent on


NeoBundleCheck  " If there are plugins not in this file, remove them
"End NeoBundle Scripts-------------------------

" Airline

let g:airline_powerline_fonts = 1


" Language specific plugins
"
" HTML5.vim
	let g:html5_aria_attributes_complete = 0
