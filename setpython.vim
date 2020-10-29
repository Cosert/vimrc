set autowrite
source $VIMRC/code-editor.vim

let b:PyMakeTp=0
set makeprg=python3\ %
"set makeprg=pypy3\ %
nnoremap <C-F5> :call PyMakeTurn()<CR>
nnoremap <F6> :call PyMakeTurn()<CR>
if has('nvim')
    if has('unix')
        nnoremap <F5> :w<CR>:term time python3 ./%<CR>i
        inoremap <F5> <ESC>:w<CR>:term time python3 ./%<CR>i
    else
        nnoremap <F5> :w<CR>:term python3 ./%<CR>i
        inoremap <F5> <ESC>:w<CR>:term python3 ./%<CR>i
    endif
elseif has('gui_running')
    nnoremap <F5> :w<CR>:term python3 ./%<CR>
    inoremap <F5> <ESC>:w<CR>:term python3 ./%<CR>
else
    nnoremap <F5> :make<CR>
    inoremap <F5> <ESC>:make<CR>
endif

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
        elseif has('gui_running')
            nnoremap <F5> :w<CR>:term python3 ./%<CR>
            inoremap <F5> <ESC>:w<CR>:term python3 ./%<CR>
        endif
        set makeprg=python3\ %
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
        elseif has('gui_running')
            nnoremap <F5> :w<CR>:term pypy3 ./%<CR>
            inoremap <F5> <ESC>:w<CR>:term pypy3 ./%<CR>
        endif
        set makeprg=pypy3\ %
        let b:PyMakeTp=1
    endif
endfunction

