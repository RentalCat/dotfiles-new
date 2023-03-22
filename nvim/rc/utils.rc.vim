" ディレクトリ関係 -------------------------------------------------------- {{{
let s:nvim_rc_dir =  expand('<sfile>:p:h')
let s:nvim_dir = fnamemodify(s:nvim_rc_dir . '/../', ':p:h')
function! GetNvimrcDir() abort
  return s:nvim_rc_dir
endfunction
" }}}
