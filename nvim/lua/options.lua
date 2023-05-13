local options = {
  termguicolors = true,                        -- True Color
  lazyredraw = true,                           -- スクリプト実行中に再描画しない (重たくなるので)
  number = true,                               -- 行数表示
  relativenumber = true,                       -- 相対行表示
  cursorline = true,                           -- カーソル行を色付け (描画処理が重たいときはコメント)
  colorcolumn = '100',                         -- 100行目に色付け (デフォルト値)
  list = true,                                 -- list モードをオンにして見えない文字を可視化
  listchars = 'space:⋅,tab:>-,trail:_,eol:↴',  -- 不可視文字設定
  wrap = false,                                -- 折り返ししない
  showmatch = true,                            -- 対応する括弧を強調表示
  diffopt = 'internal,filler,vertical,algorithm:histogram,indent-heuristic',  -- diff モード設定
  ambiwidth ='single',                         -- □や○の文字があってもカーソル位置がずれないようにする
  wildmenu = true,                             -- コマンドラインで補完時に候補一覧を表示
  wildmode = 'longest:full,full',
  showcmd = true,                              -- 入力中のコマンドをコマンドライン右側に表示する
  history = 10000,                             -- コマンドライン履歴件数 (10000 が最大値)
  ignorecase = true,                           -- 小文字で検索した場合, 大文字小文字を無視
  smartcase = true,
  incsearch = true,                            -- インクリメンタルサーチ (入力中に候補地点へ移動)
  hlsearch = true,                             -- 検索結果をハイライト
  expandtab = true,                            -- タブ文字を空白入力に置き換える
  tabstop = 4,                                 -- タブ文字の幅
  shiftround = true,
  shiftwidth = 4,                              -- vim が挿入するインデントの文字数
  softtabstop = 4,                             -- <Tab> キーを押した時の空白文字数
  autoindent = true,                           --  改行時に前の行のインデントを継続
  smartindent = true,                          -- 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
  textwidth = 0,                               -- 自動改行設定 (文字が長い場合に改行する, 0 で自動改行しない)
  backspace = 'indent,eol,start',              -- バックスペースキーを調整
  swapfile = false,                            -- .swp ファイルを作成しない
  backup = false,                              -- `~` (チルダ)ファイルを作成しない
  updatetime=500,                              -- CursorHoldの時間を設定[ms]
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  title = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- 加算関係のオプション
vim.cmd('set formatoptions+=mMj')  -- 日本語(マルチバイト文字)行の連結時には空白を入力しない + コメント行処理を行う
vim.cmd('set completeopt-=preview')  -- 補完時に変なウィンドウ開かない
