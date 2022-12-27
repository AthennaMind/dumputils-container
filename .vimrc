"        _    ________  _______
"       | |  / /  _/  |/  / __ \_____
"       | | / // // /|_/ / /_/ / ___/
"       | |/ // // /  / / _, _/ /__
"       |___/___/_/  /_/_/ |_|\___/
"
"
"
"
" Set up Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
"
" Basics
        set number
        syntax enable
        syntax on
        set hlsearch
        set showmatch
        set history=500
        set encoding=utf8
        set nobackup
        set nowb
        set noswapfile
        set shiftwidth=4
        set tabstop=4
        set ruler
        " Fast Saving
        nmap <leader>w :w!<cr>
        " Switch Buffers
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

" Colorscheme
        set background=dark

" Vundle
        set nocompatible              " be iMproved, required
        filetype off                  " required

        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()

        Plugin 'VundleVim/Vundle.vim'
        Plugin 'vim-airline/vim-airline'

        call vundle#end()

        filetype plugin indent on
