"set tenc=latin1 " Filthy hack for MRXVT

filetype off
call pathogen#incubate()
filetype plugin indent on   " detect file type and load indents and plugins
syntax on                   " turn on syntax highlighting

set gfn=Inconsolata\ Medium\ 16
set noeb
set vb

set nocompatible

" F8 for Julia esque unicode \epsilon<tab> completion
noremap <expr> <F8> LaTeXtoUnicode#Toggle()
inoremap <expr> <F8> LaTeXtoUnicode#Toggle()
" F7 to toggle spell-checking
map <silent> <F7> :set nospell!<CR>:set nospell?<CR>
" " F6 for paste toggle with a status display
" Moved to F6 as on my Mac F1-F4 all do stuff
nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
" F5 for Gundo (undo tree visualisation + navigation)
nnoremap <F5> :GundoToggle<CR>
" Fix Gundo to use Python 3
"   [ Alas, this still blows up if used under a Conda environment. ]
let g:gundo_prefer_python3 = 1

" F5 for gundo (undo tree description)
nnoremap <F5> :GundoToggle<CR>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" VIMUX: vi/tmux interaction
" See: https://blog.bugsnag.com/tmux-and-vim/ for inspiritation / origin.
" Remap Control-hjkl to Control-W Control-hjkl for split plane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>


"Wraping
set wrap
set textwidth=79
set formatoptions=qrn1
""set colorcolumn=85

"Line Numbers, always, but relative please.
set number
set relativenumber

" Tabs are evil
set tabstop=4               " number of spaces a <Tab> in the file counts for
set shiftwidth=4            " number of spaces for auto indent and line shift
set softtabstop=4           " number of spaces pressing <Tab> counts for
set expandtab               " insert tabs as spaces

" Special tabs - Smaller indents on css and html files
autocmd! Syntax css,html,htmldjango,js,markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2

" When writing English docs (vs. code), autobreak lines like a proper editor
" Automatically wrap text while typing in Markdown and rST documents
" formatoptions+=t --> auto format
autocmd! BufNewFile,BufReadPost *.md set filetype=markdown
autocmd! Filetype markdown,rst,tex,plaintex set textwidth=79 formatoptions+=t

" I always write Latex, not plain TeX.
let g:tex_flavor='latex'

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest

set visualbell
set t_vb=
" Set visual bell (no beep); but then set visualbell command to null. (No
" beeps, no screen tearing visual bell.)

set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile

"Sorting out search...
nnoremap / /\v
vnoremap / /\v
set ignorecase      " ignore case when pattern matching
set smartcase       " ... only if all characters are lower case
set gdefault
set incsearch       " highlight matches while typing search
set showmatch       " briefly jump to matching bracket
set hlsearch        " keep previous search hilights

" I can't remember what this does... magic?
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"keeps location in long broken lines
nnoremap j gj
nnoremap k gk

"Apparently this will make my life better:
"https://news.ycombinator.com/item?id=5571022
set autochdir

"The below are motivated by watching Damian Conway on vim:
"https://www.youtube.com/watch?v=aHm36-na4-4
" Remap ; to :, so I don't have to press shift...
nnoremap ; :

" Flick of colour on Column line 81, but only 81 (to spot long lines, without
" too much distraction)
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn','\%81v',100)

"Jump to previous line edited when reopening. (I often quit, recompile, come
"back to vim, it's useful to be at the same point...)
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"" Set colourscheme 
" if has('gui_running')
"    set background=dark
"    colorscheme solarized
"else
"    set background=dark
"    let g:zenburn_high_Contrast=1
"    let g:zenburn_transparent = 1 " makes terminal background black
"    colors zenburn
"endif

colors elflord "best for blue background terminal, I've found.

au BufNewFile,BufReadPost *.gin,*.gout,*.got       set ft=gin  "Shouldn't need this, but getting overridden
au BufNewFile,BufReadPost *.md                     set ft=markdown "as above...

" Async Linting
" But actually, I don't want it to run 'live'
let g:ale_lint_on_text_changed = 'never'
" Nor when I open a file...
let g:ale_lint_on_enter = 0
" So it only runs automatically when I save, which is when I want to consider
" linting.

" See: http://stackoverflow.com/questions/21572179/vim-color-scheme-overriding-the-background-settings-in-gnome-terminal
highlight Normal ctermbg=none 
" disable highlighting --> transparency correct on tmux etc.
highlight NonText ctermbg=none

" override silly underline highlight line (current editor line)
hi CursorLine cterm=NONE ctermbg=black ctermfg=white
" turn off the weird underline bar
set cursorline!

" vulnerability in modelines, 2019-06-04
set modelines=0
set nomodeline
