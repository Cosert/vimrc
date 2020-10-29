inoremap <CR> <CR>/<BS>
inoremap '' ''<LEFT>
inoremap "" ""<LEFT>
inoremap () ()<LEFT>
inoremap (' ('')<LEFT><LEFT>
inoremap (" ("")<LEFT><LEFT>
inoremap [] []<LEFT>
inoremap [' ['']<LEFT><LEFT>
inoremap [" [""]<LEFT><LEFT>
inoremap <> <><LEFT>
inoremap { { <CR>} <ESC>O<LEFT><RIGHT>
inoremap } {}<LEFT>
inoremap ; ; 
inoremap , , 
nmap <script> <silent> <F4> :call ToggleQuickfixList()<CR>
