" Vim syntax file
" Language: Gaussian (Electronic Structure Package) Input Files
" Maintainer: Jarvist Moore Frost
" Latest Revision: 27 May 2012

if exists("b:current_syntax")
  finish
endif

"Oh Fortran, always ignoring case...
syn case ignore

" Keywords

syn keyword ComBlockCmd dft tddft geometry end basis
syn keyword ComTask "#.*$"
syn keyword ComStartup "\%.*$"

syn region  ComDoubleQuote   start=+"+ skip=+\\"+ end=+"+

syn match ComAtom    " \a "

syn match ComNumber            "-\=\<\d\+\>#\="
syn match ComNumber         "\<\d\>" display
syn match   ComFloat     "\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   ComFloat     "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"  display
syn match   ComFloat     "\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

" Comments: {{{1
"==========
syn cluster     shCommentGroup  contains=shTodo,@Spell
syn keyword     shTodo          contained                       COMBAK FIXME TODO XXX NOTE
syn match       shComment                       "^\s*\zs#.*$"   contains=@shCommentGroup
syn match       shComment                       "\s\zs#.*$"     contains=@shCommentGroup
syn match       shQuickComment  contained       "#.*$"

"Let there be colour
let b:current_syntax = "com"
hi def link shTodo      Todo
hi def link ComBlockCmd  Statement
hi def link ComTask      Special
hi def link shDoubleQuote String
hi def link shComment   Comment
hi def link shNumber    Number
hi def link ComAtom      PreProc
hi def link ComStartup   Comment
hi def link ComFloat     Float
"hi def link NWDefine    Define
