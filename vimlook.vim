setf mail
set tw=72
set ff=dos

" Don't let white space hide
set list

" Detect and format lists accordingly
set formatoptions+=n
set formatlistpat=^\\s*\\%([A-Za-z]\\\|[0-9]\\+\\\|[*-]\\)[]:.)}\\t\ ]\\s*

" It's handy to have a quick gqip
nmap <leader>f gqip

" Quote and reply for selected text. <leader>q is already mapped by
" mail.vim ftplugin for quoting
exe "vmap \<leader>r \<ESC>`>ma`>mbo\<CR>\<ESC>`av`b\<leader>q\<leader>f2ji"

" Got to the start of reply
normal 2G
