filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set gfn=Inconsolata\ Medium\ 16
set noeb
set vb

call pathogen#infect()

set nocompatible
syntax on

set number

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=85

nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

if has('gui_running')
    set background=dark
    colorscheme solarized
else
    set background=dark
    let g:zenburn_high_Contrast=1
    colors zenburn
endif

 au BufNewFile,BufReadPost *.gin,*.gout,*.got        set ft=gin  "Shouldn't need this, but getting overridden
