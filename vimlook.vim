setf mail
set tw=72
set ff=dos

" Don't let white space hide
set list

" Detect and format lists accordingly
set comments=:>
set formatoptions=tncrqo
set formatlistpat=^\\s\\+(\\?\\%([A-Za-z]\\\|[0-9]\\+\\\|[*-]\\)[:.)]\\?\\s\\+

" It's handy to have a quick gqip
nmap <leader>f gqip$

" Spell check on
set spell

" Quote and reply for selected text. <leader>q is already mapped by
" mail.vim ftplugin for quoting
exe "vmap \<leader>r :\<C-U>call DoQuote()\<CR>"

" Remove stray hex characters that looks like space. This seems to be coming from bulleted lists
silent! %s/\%xa0\+/ /g
" Replace bullet characters with *
silent! %s/\%xb7\+\s*/* /g
" We don't want trailing white space either
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

function DoQuote()
    exe "normal `<ma`>mbi\<CR>\<C-U>\<CR>\<ESC>"
    exe "set tw=" . (&tw - 2)
    normal 'aV'bgq
    silent! 'a,'bs/^/> /
    normal 'b2j
    exe "set tw=" . (&tw + 2)
endfunction

command SetupMatch call _SetupMatch()
function _SetupMatch()
    match Error /\<\(\w\+\)\>\s\+\1/
endfunction
call _SetupMatch()
