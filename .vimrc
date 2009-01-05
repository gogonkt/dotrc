" 设置多编码文本
" multi-encoding setting
" set fileencodings=utf-8,cp936,big5,euc-jp,euc-kr,latin1,ucs-bom
 set fileencodings=utf-8,gbk

" 设置语法折叠
" set foldmethod=syntax 
" 设置标记折叠
 set foldmethod=marker

"set nu
syntax on
set hls
set ai
map V :w:!ispell % :e!
"set hid 就能换buffer的时候不要求save了..
set hid
set ts=4 sw=4 "让tab变成4个空字符
