if exists("did_load_myfiletypes")
 finish
endif
let did_load_myfiletypes= 1

augroup filetypedetect
 au BufNewFile,BufReadPost *.pdb         setf pdb
augroup END

augroup filetypedetect
 au BufNewFile,BufReadPost *.nw     setf nw
augroup END

augroup filetypedetect
 au BufNewFile,BufReadPost *.com            setf com
augroup END
