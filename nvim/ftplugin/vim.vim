scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

" 80 文字目に色を付ける
setlocal colorcolumn=80

" タブ文字の幅
setlocal tabstop=2

" vim が挿入するインデントの文字数
setlocal shiftwidth=2

" <Tab> キーを押した時の空白文字数
setlocal softtabstop=2

" 区切り文字追加
setlocal iskeyword+=:,#

let &cpoptions = s:save_cpo
