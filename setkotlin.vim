set autowrite
source $CODEMAKE/codemake.vim

inoremap "<CR> """ <CR>"""<ESC>O<Up><Down>
inoremap :int :Int
inoremap :long :Long
inoremap :doub :Double
inoremap :str :String
inoremap :byte :Byte
inoremap :bool :Boolean
inoremap .tint .toInt()
inoremap .tlong .toLong()
inoremap .tdoub .toDouble()
inoremap .tstr .toString()
inoremap .tbyte .toByte()
inoremap .tbool .toBoolean()
inoremap .tli .toList()
inoremap .tmli .toMutableList()

let b:KtMakeTp=0
nnoremap <C-F5> :call KtMakeTurn()<CR>
nnoremap <F5> :call CompileKt()<CR>
inoremap <F5> <ESC>:call CompileKt()<CR>

if has('nvim')
    if has('unix')
        nnoremap <F6> :term time ./%<.l<CR>i
    else
        nnoremap <F6> :term %<.l<CR>i
    endif
else
    nnoremap <F6> :call RunKt()<CR>
endif

function CompileKt()
    if b:KtMakeTp==1
        set makeprg=kotlinc\ -J-XX:+TieredCompilation\ -J-XX:TieredStopAtLevel=1\ %\ -include-runtime\ -d\ %<.jar\ -DLOCAL_TEST
    else
        set makeprg=kotlinc-native\ -g\ %\ -o\ %<\ -opt\ -DLOCAL_TEST
    endif
    
    make
    
    if b:KtMakeTp==0 && has('win32')
        !mv %<.exe %<.l
    elseif b:KtMakeTp==0
        !mv %<.kexe %<.l
    endif
endfunction

function RunKt()
    if b:KtMakeTp==1
        if has('unix')
            exec "!time java -Xms1280m -Xmx128m -Xss64m -XX:+UseSerialGC -jar %<.jar"
        else
            exec "!java -Xms1280m -Xmx128m -Xss64m -XX:+UseSerialGC -jar %<.jar"
        endif
    else
        if has('unix')
            exec "!time ./%<.l"
        else
            exec "! %<.l"
        endif
    endif
endfunction

function KtMakeTurn()
    if b:KtMakeTp==1
        if has('nvim')
            if has('unix')
                nnoremap <F6> :term time ./%<.l<CR>i
            else
                nnoremap <F6> :term %<.l<CR>i
            endif
        endif
        let b:KtMakeTp=0
    else
        if has('nvim')
            if has('unix')
                nnoremap <F6> :term time java -Xms1280m -Xmx128m -Xss64m -XX:+UseSerialGC -jar %<.jar<CR>i
            else
                nnoremap <F6> :term java -Xms1280m -Xmx128m -Xss64m -XX:+UseSerialGC -jar %<.jar<CR>i
            endif
        endif
        let b:KtMakeTp=1
    endif
endfunction

