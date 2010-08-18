setf mail
set textwidth=72
set fileformat=dos

" Don't let white space hide
set listchars=tab:>-,trail:~
set list

" Set expand tabs, soft tab stop to 2 spaces
set expandtab
set softtabstop=2

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

" Collapse multiple empty lines to a single one
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

" As if nothing happened...
set nomodified

" Got to the start of reply
normal 2G

" Function that does the requested level of quoting
function DoQuote(level)
    " Remove all quotes before every line
    silent! '<,'>s/^\(> \?\)*//g

    " Determine the string to prefix with
    let level = (a:level > 0) ? a:level : 1
    let prefix_string = repeat("> ", level)

    exe "normal `<ma`>mb"
    let save_tw = &tw
    exe "set tw=" . (&tw - (level * 2))
    normal 'aV'bgq
    exe "silent! 'a,'bs/^/" . prefix_string . "/"
    silent! 'a,'bs/>\s\{2,\}>/> >/g
    normal 'b2j
    exe "set tw=" . save_tw
endfunction

" Error highlighting. The text width setting is used in setting up the match and
" thus it has to be read at runtime. The command does that if you happen to change
" the text width value
command SetupMatch call _SetupMatch()
function _SetupMatch()
    if v:version > 702
        exe 'match Error /\%(^\s*\|^>.*\)\@<!\s\s\+\|\<\(\w\+\)\>\s\+\<\1\>/'
        " Using colorcolumn option to set right margin
        exe 'set colorcolumn=' . (&tw + 1)
    else
        exe 'match Error /\%(^\s*\|^>.*\)\@<!\s\s\+\|\<\(\w\+\)\>\s\+\<\1\>\|\%>'.(&tw + 1).'c/'
    endif
endfunction
call _SetupMatch()
