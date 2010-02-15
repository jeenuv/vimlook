setf mail
set tw=72
set ff=dos

" Don't let white space hide
set list

" Detect and format lists accordingly
set formatoptions=tan
set formatlistpat=^\\s*\\%([A-Za-z]\\\|[0-9]\\+\\\|[*-]\\)[]:.)}\\t\ ]\\s*

" It's handy to have a quick gqip
nmap <leader>f gqip

" Quote and reply for selected text. <leader>q is already mapped by
" mail.vim ftplugin for quoting
exe "vmap \<leader>r \<ESC>`<ma`>mbi\<CR>\<CR>\<ESC>'aV'bgq'aV'b\<leader>q'b2j"

" Remove stray hex characters that looks like space
silent! %s/\%xa0/ /g
silent! %s/\s*$//

" Collapse multiple empty lies to a single one
let i = 2
while i < line("$")
    if match(getline(i), '^\s*$') != -1 && match(getline(i + 1), '^\s*$') != -1
        exe i . " delete"
    else
        let i += 1
    endif
endwhile

" Clear all highlighting from above search and replace
noh

" As if nothign happened...
set nomodified

" Got to the start of reply
normal 2G
