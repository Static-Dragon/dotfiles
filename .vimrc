"================================================
" Maintainer: Justin T. Doyle
" Last Edited: Jul 13th 2016
"================================================

"=> Pathogen {{{

execute pathogen#infect()

" }}}

" => General {{{

" Set how many lines of history to be remembered
set history=700
"filetype plugins
filetype plugin on
filetype indent on

"Autoread if file is changed from outside
set autoread

" Disable annoying error bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" }}} 

" => VIM UI {{{

let $LANG='en'
set langmenu=en
set wildmenu
set wildignore=*.0,*~,*.pyc "Ignore compiled files
set ruler "Always show ruler
set cmdheight=2 "Height of command bar
set ignorecase "Case insensitive search
set magic "Allow for regex in searches
set hlsearch "Search result highlighting

" ==> Folding {{{

set foldmethod=marker
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" }}}

" }}}

" => Color + font {{{

" Syntax highlighting
syntax enable

" utf as defualt
set encoding=utf8

"Unix as default type
set ffs=unix,dos,mac

" Colorscheme

set background=dark
colorscheme gruvbox


" }}}

" => File, backup, and undo {{{

" Disable swap file
set noswapfile

" }}}

" => Text, tab and indents {{{

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak after 500 chars
set lbr
set tw=500

set ai "auto indent
set wrap "wrap lines

" }}}

" => Plugins {{{
 
" ==> NERDTree {{{
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" }}}

" ==> NERDTree-tabs {{{

let g:nerdtree_tabs_open_on_console_startup=0  "Open on startup

" }}}

" ==> vim-airline {{{

let g:airline_powerline_fonts = 1
set laststatus=2

"AirlineTheme badwolf

" }}}

" ==> vim-litecorrect {{{

augroup litecorrect
	autocmd!
	autocmd FileType markdown,mkd call litecorrect#init()
	autocmd FileType textile call litecorrect#init()
augroup END

" }}}

" ==> supertab {{{


" }}}

" ==> neocomplete.vim {{{

let g:neocomplete#enable_at_startup = 1 "Enable neocomplete at startup
let g:neocomplete#enable_smart_case = 1

" ===> filetype completion {{{

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
 endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" }}}

" }}}

" ==> vim-pencil {{{

augroup pencil
autocmd!
	autocmd FileType markdown,mkd call pencil#init()
		\ | call litecorrect#init()
		\ | setl spell spl=en_us fdl=4 noru nonu nornu
		\ | setl fdo+=search
	autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
		\   call pencil#init({'wrap': 'hard', 'textwidth': 72})
		\ | call litecorrect#init()
		\ | setl spell spl=en_us et sw=2 ts=2 noai
	autocmd Filetype mail         call pencil#init({'wrap': 'hard', 'textwidth': 60})
		\ | call litecorrect#init()
		\ | setl spell spl=en_us et sw=2 ts=2 noai nonu nornu
	autocmd Filetype html,xml     call pencil#init({'wrap': 'soft'})
		\ | call litecorrect#init()
		\ | setl spell spl=en_us et sw=2 ts=2
augroup END

" }}}

" }}}
