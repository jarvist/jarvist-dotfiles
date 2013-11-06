" pdb.vim
"   Author: Charles E. Campbell, Jr.
"   Date:   Mar 18, 2009
"   Version: 1a NOT RELEASED
"     Adapted to take away the hard coded colours (which did not work) and change columns by Jarvist Moore Frost, 2012-05-25.
" ---------------------------------------------------------------------
"  Initialization {{{1
" Remove any old syntax stuff hanging around
syntax clear

" ---------------------------------------------------------------------
"  Syntax {{{1
syn match pdbCol1 /^.*\%5v/      nextgroup=pdbCol2
syn match pdbCol2 /\%6v.*\%11v/ contained       nextgroup=pdbCol3
syn match pdbCol3 /\%14v.*\%17v/        contained       nextgroup=pdbCol4
syn match pdbCol4 /\%18v.*\%21v/        contained       nextgroup=pdbCol5
syn match pdbCol5 /\%24v.*\%35v/        contained       nextgroup=pdbCol6
syn match pdbCol6 /\%35v.*\%43v/        contained       nextgroup=pdbCol7
syn match pdbCol7 /\%43v.*\%51v/        contained       nextgroup=pdbCol8
syn match pdbCol8 /\%51v.*\%58v/        contained       nextgroup=pdbCol9
syn match pdbCol9 /\%58v.*\%64v/        contained       nextgroup=pdbCol10
syn match pdbCol10      /\%64v.*\%73v/  contained       nextgroup=pdbCol11
syn match pdbCol11      /\%73v.*$/       contained

" ---------------------------------------------------------------------
"  Highlighting {{{1
if !exists("b:did_pdb_syntax_inits")
  let b:did_pdb_syntax_inits = 1

  hi def link pdbCol1 Macro
  hi def link pdbCol2 Number
  hi def link pdbCol3 Constant
  hi def link pdbCol4 Function
  hi def link pdbCol5 Cyan
  hi def link pdbCol6 White
  hi def link pdbCol7 Red
  hi def link pdbCol8 Yellow
  hi def link pdbCol9 Green
  hi def link pdbCol10  Magenta
  hi def link pdbCol11  Cyan
  endif
" ---------------------------------------------------------------------
" vim: ts=4 fdm=marker
