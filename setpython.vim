set autowrite
source $CODEMAKE/codemake.vim

inoremap :<CR> : <CR><LEFT><RIGHT>
inoremap "<CR> """ <CR>"""<ESC>O<Up><Down>
inoremap (. ().

let b:PyMakeTp=0
if has('unix')
    nnoremap <F29> :let b:PyMakeTp = !b:PyMakeTp<CR>
else
    nnoremap <C-F5> :call PyMakeTurn()<CR>
endif

nnoremap <F5> :call RunPy()<CR>
inoremap <F5> <ESC>:call RunPy()<CR>

function RunPy()
    exec "w"
    if b:PyMakeTp==0
        if has('gui_running') || has('nvim')
            if has('unix')
                exec "term time python3 %"
            else
                exec "term python3 %"
            endif
        else
            set makeprg=python3\ %
            make
        endif
    else
        if has('gui_running') || has('nvim')
            if has('unix')
                exec "term time pypy3 %"
            else
                exec "term pypy3 %"
            endif
        else
            set makeprg=pypy3\ %
            make
        endif
    endif
    if has('nvim')
        call feedkeys("i")
    endif
endfunction

