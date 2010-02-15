setf mail
set tw=72
set ff=dos

" Format lines according to width
normal 2GVGgq

" Quote replies and temporarily turn highlighting off
silent! 2,$s/^/> /
silent! 2,$s/\s*$//
noh

" Don't let white space hide
set list

" User hasn't modified it yet
set nomodified

" Detect and format lists accordingly
set formatoptions+=n
set formatlistpat=^\\s*\\%([A-Za-z]\\\|[0-9]\\+\\)[]:.)}\\t\ ]\\s*
