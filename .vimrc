" " " " " " " " " " " " " " " " " " " " " "
"        _    ________  _______           "
"       | |  / /  _/  |/  / __ \_____     "
"       | | / // // /|_/ / /_/ / ___/     "
"       | |/ // // /  / / _, _/ /__       "
"       |___/___/_/  /_/_/ |_|\___/       "
"                                         "
" " " " " " " " " " " " " " " " " " " " " "

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
set nocompatible
filetype plugin indent on
filetype off

set modelines=0
" Show line numbers
set number
" Show file stats
set ruler
" Blink cursor on error
set visualbell
" Encoding
set encoding=utf-8
" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim
" Allow hidden buffers
set hidden
" Rendering
set ttyfast
" Status bar
set laststatus=2
" Last line
set showmode
set showcmd
" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=/root/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'

call vundle#end()

