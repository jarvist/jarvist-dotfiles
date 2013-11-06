" Vim syntax file
" Language: GULP (General Utility Lattice Program) Input Files
" Maintainer: Jarvist Moore Frost
" Latest Revision: 7 Nov 2013

if exists("b:current_syntax")
  finish
endif

"Oh Fortran, always ignoring case...
syn case ignore

" Keywords

syn keyword NWBlockCmd cell fractional space species buck end
syn keyword NWTask maxcyc stepmx dump every
syn keyword NWStartup single prop conp comp phon pot
syn keyword GULPType core shel shell

syn region  shDoubleQuote   start=+"+ skip=+\\"+ end=+"+

syn match       shNumber            "-\=\<\d\+\>#\="

syn match NWAtom    " \u "
syn match NWAtom    " \u\a "
syn match NWAtom    "^\u\a "
syn match NWAtom    "^\u "

syn match   NWOperator           "[*/+-><^!~%^&|=.:;,$?]"


" Comments: {{{1
"==========
syn cluster     shCommentGroup  contains=shTodo,@Spell
syn keyword     shTodo          contained                       COMBAK FIXME TODO XXX NOTE
syn match       shComment                       "^\s*\zs#.*$"   contains=@shCommentGroup
syn match       shComment                       "\s\zs#.*$"     contains=@shCommentGroup
syn match       shQuickComment  contained       "#.*$"

"Let there be colour
let b:current_syntax = "nw"
hi def link NWTodo      Todo
hi def link shTodo      Todo
hi def link NWBlockCmd  Statement
hi def link NWTask      Special
hi def link shDoubleQuote String
hi def link shComment   Comment
hi def link shNumber    Number
hi def link NWAtom      PreProc
hi def link NWStartup   Special
hi def link NWOperator  Operator
hi def link GULPType    PreProc 
"hi def link NWDefine    Define
