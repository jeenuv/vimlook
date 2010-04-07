setf mail
set textwidth=72
set fileformat=dos

" Don't let white space hide
set list

" Detect and format lists accordingly
set comments=:>
set formatoptions=tncrqo
set formatlistpat=^\\s\\+\\%(\\%((\\?\\%([A-Z]\\\|[a-z]\\{1,3\\}\\\|\\d\\+\\)\\)[:.)]\\\|[-*+]\\)\\s\\+

" It's handy to have a quick gqip
nmap <leader>f gqip$

" Spell check on
set spell

vmap > :<C-U>call DoQuote(v:count)<CR>
nmap > vip>

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

function DoQuote(level)
    " Remove all quotes before
    silent! '<,'>s/^\%(> \?\)*//g

    " Determine the string to prefix with
    let level = (a:level > 0) ? a:level : 1
    let prefix_string = repeat("> ", level)

    exe "normal `<ma`>mb"
    let save_tw = &tw
    exe "set tw=" . (&tw - (level * 2))
    normal 'aV'bgq
    exe "silent! 'a,'bs/^/" . prefix_string . "/"
    silent! 'a,'bs/>  /> /g
    normal 'b2j
    exe "set tw=" . save_tw
endfunction

command SetupMatch call _SetupMatch()
function _SetupMatch()
    exe 'match Error /\%(^\s*\|^>.*\)\@<!\s\s\+\|\<\(\w\+\)\>\s\+\<\1\>\|\%>'.(&tw + 1).'c/'
endfunction
call _SetupMatch()
