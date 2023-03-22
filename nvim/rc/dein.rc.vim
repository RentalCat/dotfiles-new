scriptencoding utf-8

" dein 自体のインストール設定 --------------------------------------------- {{{
" プラグインがインストールされるディレクトリ: dotfiles/nvim/.cache/dein/
let s:dein_dir = resolve(expand('<sfile>:h').'/../.cache/dein')

" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" インストールディレクトリがない場合は作成
if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
endif

" runtimepath 上に '/dein.vim' へのパスが無い
if &runtimepath !~# '/dein.vim'
  " リポジトリも存在しない場合は git clone する
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  " runtimepath に dain.vim を追加
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" }}}

" プラグイン読込設定 ------------------------------------------------------ {{{
" 読み込みが完了していない場合は読み込み
if dein#load_state(s:dein_dir)
  " 読込処理開始
  call dein#begin(s:dein_dir)
  " call dein#begin(s:dein_dir, [expand('<sfile>')]
  "       \ + split(glob(expand('<sfile>:h') . '/*.toml'), '\n'))

  " toml ロード, キャッシュもするらしい
  call dein#load_toml(expand('<sfile>:h') . '/dein.toml', {'lazy': 0})
  call dein#load_toml(expand('<sfile>:h') . '/dein_lazy.toml', {'lazy': 1})

  " 設定完了
  call dein#end()
  call dein#save_state()
endif

" filetype, syntax 設定 (required)
filetype plugin indent on
syntax on
" }}}

" plugin installation check ----------------------------------------------- {{{
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check ----------------------------------------------------- {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}
