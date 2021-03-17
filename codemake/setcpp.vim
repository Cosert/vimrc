set autowrite
source $VIMRC/codemake/codemake.vim
packadd termdebug

if &filetype == 'c'
	set makeprg=gcc\ %\ -o\ %<.run\ -g\ -std=c11\ -O2\ -pthread\ -Wall\ -Wextra\ -Wconversion\ -Wfatal-errors\ -DLOCAL_TEST
else
	set makeprg=g++\ %\ -o\ %<.run\ -g\ -std=c++17\ -O3\ -pthread\ -Wall\ -Wextra\ -Wconversion\ -Wfatal-errors\ -DLOCAL_TEST
endif

nnoremap <F5> :make<CR>
inoremap <F5> <ESC>:make<CR>
nnoremap <F6> :call RunCpp()<CR>
nnoremap <C-F6> :call RunCpp()<CR>

function RunCpp()
    if has('gui_running') || has('nvim')
        if has('unix')
            exec "term time ./%<.run"
        else
            exec "term %<.run"
        endif
    else
        if has('unix')
            exec "!time ./%<.run"
        else
            exec "! %<.run"
        endif
    endif
    if has('nvim')
        call feedkeys("i")
    endif
endfunction

nnoremap <F7> : Termdebug %<.run <CR>
"nnoremap <F8> : call FormatCode()<CR>

