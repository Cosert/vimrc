set autowrite
source $CODEMAKE/codemake.vim

inoremap :<CR> : <CR>
inoremap "<CR> """ <CR>"""<ESC>O<Up><Down>

let b:PyMakeTp=0
nnoremap <C-F5> :call PyMakeTurn()<CR>
nnoremap <F6> :call PyMakeTurn()<CR>

if has('nvim')
    if has('unix')
        nnoremap <F5> :w<CR>:term time python3 ./%<CR>i
        inoremap <F5> <ESC>:w<CR>:term time python3 ./%<CR>i
    else
        nnoremap <F5> :w<CR>:term python3 %<CR>i
        inoremap <F5> <ESC>:w<CR>:term python3 %<CR>i
    endif
else
    nnoremap <F5> :call RunPy()<CR>
    inoremap <F5> <ESC>:call RunPy()<CR>
endif

function RunPy()
    if b:PyMakeTp==0
        if has('unix') && has('gui_running')
            exec "w"
            exec "term time python3 %"
        elseif has('gui_running')
            exec "w"
            exec "term python3 %"
        else
            set makeprg=python3\ %
            make
        endif
    else
        if has('unix') && has('gui_running')
            exec "w"
            exec "term time pypy3 %"
        elseif has('gui_running')
            exec "w"
            exec "term pypy3 %"
        else
            set makeprg=pypy3\ %
            make
        endif
    endif
endfunction

function PyMakeTurn()
    if b:PyMakeTp==1
        if has('nvim')
            if has('unix')
                nnoremap <F5> :w<CR>:term time python3 ./%<CR>i
                inoremap <F5> <ESC>:w<CR>:term time python3 ./%<CR>i
            else
                nnoremap <F5> :w<CR>:term python3 ./%<CR>i
                inoremap <F5> <ESC>:w<CR>:term python3 ./%<CR>i
            endif
        endif
        let b:PyMakeTp=0
    else
        if has('nvim')
            if has('unix')
                nnoremap <F5> :w<CR>:term time pypy3 ./%<CR>i
                inoremap <F5> <ESC>:w<CR>:term time pypy3 ./%<CR>i
            else
                nnoremap <F5> :w<CR>:term pypy3 ./%<CR>i
                inoremap <F5> <ESC>:w<CR>:term pypy3 ./%<CR>i
            endif
        endif
        let b:PyMakeTp=1
    endif
endfunction

