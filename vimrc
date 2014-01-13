filetype off
call pathogen#incubate()
filetype plugin indent on

set gfn=Inconsolata\ Medium\ 16
set noeb
set vb

set nocompatible
syntax on

" F7 to toggle spell-checking
map <silent> <F7> :set nospell!<CR>:set nospell?<CR>
"
" " F2 for paste toggle with a status display
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"Wraping
set wrap
set textwidth=79
set formatoptions=qrn1
""set colorcolumn=85

"Numbers, always, but relative please.
set number
set relativenumber

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

"Sorting out search...
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

"keeps location in long broken lines
nnoremap j gj
nnoremap k gk

"Apparently this will make my life better:
"https://news.ycombinator.com/item?id=5571022
set autochdir



if has('gui_running')
    set background=dark
    colorscheme solarized
else
    set background=dark
    let g:zenburn_high_Contrast=1
    colors zenburn
endif

 au BufNewFile,BufReadPost *.gin,*.gout,*.got        set ft=gin  "Shouldn't need this, but getting overridden
