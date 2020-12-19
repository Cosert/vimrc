set autowrite
source $VIMRC/codemake/codemake.vim
packadd termdebug

if &filetype == 'c'
	set makeprg=gcc\ %\ -o\ %<.l\ -g\ -std=c11\ -O2\ -pthread\ -Wall\ -Wextra\ -Wconversion\ -Wfatal-errors\ -DLOCAL_TEST
else
	set makeprg=g++\ %\ -o\ %<.l\ -g\ -std=c++17\ -O3\ -pthread\ -Wall\ -Wextra\ -Wconversion\ -Wfatal-errors\ -DLOCAL_TEST
endif

nnoremap <F5> :make<CR>
inoremap <F5> <ESC>:make<CR>
nnoremap <F6> :call RunCpp()<CR>
nnoremap <C-F6> :call RunCpp()<CR>

function RunCpp()
    if has('gui_running') || has('nvim')
        if has('unix')
            exec "term time ./%<.l"
        else
            exec "term %<.l"
        endif
    else
        if has('unix')
            exec "!time ./%<.l"
        else
            exec "! %<.l"
        endif
    endif
    if has('nvim')
        call feedkeys("i")
    endif
endfunction

nnoremap <F7> : Termdebug %<.l <CR>
"nnoremap <F8> : call FormatCode()<CR>

