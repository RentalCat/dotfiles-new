scriptencoding utf-8

if !exists('g:lightline')
  let g:lightline = {}
  let g:mylightline = {}
endif

let g:lightline = {
\   'colorscheme': 'molokai',
\   'active': {
\     'left': [
\       ['mode', 'paste'],
\       ['gitbranch', 'filemark', 'myfilename'],
\       ['funcname'],
\     ],
\     'right': [
\       ['linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok', 'lineinfo', 'charvaluehex'],
\       ['percent'],
\       ['fileformat', 'fileencoding', 'filetype'],
\     ],
\   },
\   'inactive': {
\     'left': [
\       ['filename'],
\     ],
\     'right': [
\       ['lineinfo'],
\       ['percent'],
\     ],
\   },
\   'component': {
\     'paste': '%{&paste ? "PST" : ""}',
\     'charvaluehex': '0x%04B',
\     'lineinfo': "\ue0a1 %2l:%-2v",
\   },
\   'component_function': {
\     'gitbranch'   : 'g:mylightline.getGitBranch',
\     'filemark'    : 'g:mylightline.getFilemark',
\     'myfilename'  : 'g:mylightline.getFilename',
\     'funcname'    : 'g:mylightline.getFuncname',
\     'debug'       : 'g:mylightline.getDebugText',
\     'fileformat'  : 'g:mylightline.getFileFormat',
\     'filetype'    : 'g:mylightline.getFileType',
\     'fileencoding': 'g:mylightline.getFileEncoding',
\   },
\   'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
\   'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"},
\   'mode_map': {
\     'n': 'NOR',     'i': 'INS', 'R': 'REP', 'v': 'VIS', 'V': 'V-L',
\     "\<C-v>": 'V-B','c': 'COM', 's': 'SEL', 'S': 'S-L', "\<C-s>": 'S-B',
\     't': 'TER',
\   },
\ }

let s:displayable_components = {}
let s:margin = 4
let s:mode_len = 6
let s:paste_len = 6
let s:persent_len = 7
let s:charvalue_len = 9
let s:ale_len = 6

function! s:lineInfoLen() abort
  " 現在の位置情報文字列の長さ
  let l:line_num = max([strlen(line('.')), 2])
  let l:col_num = max([strlen(col('.')), 2])
  return l:line_num + l:col_num + 6
endfunction

function! s:filemark() abort
  " 読込専用 & 編集状態 の文字列
  if !&modifiable || &readonly
    " 読込専用
    return "\ue0a2"
  elseif expand('%') =~? '^fugitive://'
    return "\uf440"
  elseif &modified
    " 編集済み
    return '+'
  endif
  " それ以外
  return ''
endfunction

function! s:gitBranchName() abort
  " Git branch名
  try
    let l:head = fugitive#head()
    if l:head !=# ''
      return "\ue0a0 ". l:head
    endif
  catch /E117.*/
  endtry
  return ''
endfunction

function! s:filename() abort
  " 現在のファイル名
  return expand('%:t')
endfunction

function! s:funcname() abort
  " カーソル上の関数・クラス名
  if !exists('*cfi#get_func_name')
    return ''
  endif
  return cfi#get_func_name()
endfunction

function! s:relPath() abort
  " 相対パス
  let l:filepath = expand('%')
  if l:filepath =~? '^fugitive://'
    let l:filepath = substitute(
    \   l:filepath, '^fugitive:\/\/\(.*\)\.git\/\/[a-zA-Z0-9]*\/\(.*\)', '\2', 'g'
    \ )
  endif
  return substitute(l:filepath, s:filename(), '', 'g')
endfunction

function! s:absPath() abort
  " 絶対パス
  let l:filepath = expand('%:p')
  if l:filepath =~? '^fugitive://'
    let l:filepath = substitute(
    \   l:filepath, '^fugitive:\/\/\(.*\)\.git\/\/[a-zA-Z0-9]*\/\(.*\)', '\1\2', 'g'
    \ )
  endif
  return substitute(l:filepath, s:relPath() . s:filename(), '', 'g')
endfunction

function! s:fileformat() abort
  " ファイルフォーマット
  return &fileformat
endfunction

function! s:filetype() abort
  " ファイルタイプ
  return &filetype ==# '' ? 'no ft' : &filetype
endfunction

function! s:fileencoding() abort
  " ファイルエンコーディング
  return &fileencoding ==# '' ? &fileencoding : &encoding
endfunction

function! s:updateDisplayableComponents() abort
  let s:displayable_components = {}
  let l:rlen = winwidth(0) - s:margin
  " 絶対に表示するもの(mode, lineinfo, percent)を引く
  let l:rlen -= s:mode_len + (&paste ? s:paste_len : 0) + s:lineInfoLen() +
        \       s:persent_len + s:charvalue_len + s:ale_len

  " filemark
  let l:rlen = s:setDisplayableComponents('filemark', s:filemark(), l:rlen, 3)

  " ファイル名
  let l:rlen = s:setDisplayableComponents('filename', s:filename(), l:rlen, 3)
  if l:rlen <= 0 | return | endif  " 表示枠足りなかったらここで終了

  " 関数・クラス名
  let l:rlen = s:setDisplayableComponents('funcname', s:funcname(), l:rlen, 3)
  if l:rlen <= 0 | return | endif  " 表示枠足りなかったらここで終了

  " git 情報
  let l:rlen = s:setDisplayableComponents('git', s:gitBranchName(), l:rlen, 3)
  if l:rlen <= 0 | return | endif  " 表示枠足りなかったらここで終了

  " 相対パス (カレントディテクトリから該当ファイルのあるディレクトリパスまで)
  let l:rlen = s:setDisplayableComponents('relpath', s:relPath(), l:rlen, 0)
  if l:rlen <= 0 | return | endif  " 表示枠足りなかったらここで終了

  " ファイルタイプ
  let l:rlen = s:setDisplayableComponents('ftype', s:filetype(), l:rlen, 3)
  " ファイルエンコーディング
  let l:rlen = s:setDisplayableComponents('fencoding', s:fileencoding(), l:rlen, 3)
  " ファイルタイプ
  let l:rlen = s:setDisplayableComponents('fformat', s:fileformat(), l:rlen, 3)
  if l:rlen <= 0 | return | endif  " 表示枠足りなかったらここで終了

  " 絶対パス (ルートディレクトリからカレントディテクトリまで)
  let l:rlen = s:setDisplayableComponents('abspath', s:absPath(), l:rlen, 0)
  if l:rlen <= 0 | return | endif  " 表示枠足りなかったらここで終了

  " デバッグ用
  let s:displayable_components['debug'] = repeat('x', l:rlen)
endfunction

function! s:setDisplayableComponents(key, value, limit, margin) abort
  let l:value_len = strlen(a:value)
  let l:rlen = a:limit - (l:value_len ? l:value_len + a:margin : 0)
  if l:rlen >= 0
    let s:displayable_components[a:key] = a:value
  endif
  return l:rlen
endfunction

function! s:getDisplayableComponents(key) abort
  if has_key(s:displayable_components, a:key)
    return s:displayable_components[a:key]
  else
    return ''
  endif
endfunction

function! g:mylightline.getGitBranch() abort
  return s:getDisplayableComponents('git')
endfunction

function! g:mylightline.getFilemark() abort
  return s:getDisplayableComponents('filemark')
endfunction

function! g:mylightline.getFilename() abort
  return s:getDisplayableComponents('abspath')
        \ . s:getDisplayableComponents('relpath')
        \ . s:getDisplayableComponents('filename')
endfunction

function! g:mylightline.getFuncname() abort
  return s:getDisplayableComponents('funcname')
endfunction

function! g:mylightline.getDebugText() abort
  " デバッグ用
  return s:getDisplayableComponents('debug')
endfunction

function! g:mylightline.getFileFormat() abort
  return s:getDisplayableComponents('fformat')
endfunction

function! g:mylightline.getFileType() abort
  return s:getDisplayableComponents('ftype')
endfunction

function! g:mylightline.getFileEncoding() abort
  return s:getDisplayableComponents('fencoding')
endfunction

augroup mylightline
  autocmd!
  " バッファに入った時、カーソルが動いた時に情報を更新する
  autocmd BufWinEnter,CursorMovedI,CursorMoved,CursorHold,CursorHoldI,BufWritePost,FileWritePost * call s:updateDisplayableComponents()
augroup END
