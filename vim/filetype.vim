if exists("did_load_myfiletypes")
 finish
endif
let did_load_myfiletypes= 1

augroup filetypedetect
 au! BufNewFile,BufReadPost *.pdb         setf pdb
 au! BufNewFile,BufReadPost *.nw     setf nw
 au! BufNewFile,BufReadPost *.com            setf com
 au! BufNewFile,BufReadPost *.gin,*.gout,*.got         setf gin
augroup END

