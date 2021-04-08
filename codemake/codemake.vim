set autowrite

function! FormatCode()
    exec "w"
    exec "!astyle --style=ansi -n %"
    exec "e %"
endfunction

function! s:GetBufferList()
    redir =>buflist 
    silent! ls 
    redir END 
    return buflist 
endfunction

function! ToggleQuickfixList()
    for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
        if bufwinnr(bufnum) != -1
            "cclocall Run() <CR>
            close
            return
        endif
    endfor
    let winnr = winnr()
    if exists("g:toggle_list_copen_command")
        exec(g:toggle_list_copen_command)
    else
        copen
    endif
    if winnr() != winnr
        wincmd p
    endif
endfunction

inoremap <CR> <CR>/<BS>
inoremap ' ''<LEFT>
inoremap '<CR> '
inoremap '' ''
inoremap '<SPACE> ' '
inoremap '. '.'
inoremap '( '('
inoremap ') ')'
inoremap '\ '\'<LEFT>
inoremap " ""<LEFT>
inoremap "<CR> "
inoremap "" ""
inoremap "<SPACE> " "
inoremap "\ "\"<LEFT>
inoremap ( ()<LEFT>
inoremap (<CR> (
inoremap )<CR> )
inoremap (<SPACE> (
inoremap )<SPACE> )
inoremap )( (
inoremap )) )
inoremap () ()
inoremap (, (,)<LEFT><LEFT>
inoremap (' ('')<LEFT><LEFT>
inoremap (" ("")<LEFT><LEFT>
inoremap [ []<LEFT>
inoremap [<CR> [
inoremap ]<CR> ]
inoremap ]<SPACE> ]
inoremap [<SPACE> [
inoremap ][ [
inoremap ]] ]
inoremap [] []
inoremap [' ['']<LEFT><LEFT>
inoremap [" [""]<LEFT><LEFT>
inoremap <> <><LEFT>
inoremap << <<
inoremap { { <CR>} <ESC>O<LEFT><RIGHT>
inoremap ({ () { <CR>} <ESC>O<LEFT><RIGHT>
inoremap } {}<LEFT>
inoremap ; ; 
inoremap , , 
nnoremap <script> <silent> <F4> :call ToggleQuickfixList()<CR>

