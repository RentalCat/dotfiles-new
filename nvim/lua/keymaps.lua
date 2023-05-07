-- Leader設定
vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- <ESC><ESC>  ==> ハイライトを消す
vim.keymap.set('n', '<Esc><Esc>', ':<C-u>set nohlsearch<CR>')

-- ZQ          ==> 全ファイルクローズ (従来の :q! やめました)
vim.keymap.set('n', 'ZQ', ':<C-u>windo q<CR>', {noremap = true})

-- ZE          ==> 全ファイル更新
vim.keymap.set('n', 'ZE', ':<C-u>windo e<CR>', {noremap = true})

-- タブ関係
vim.keymap.set('n', 't'       , '<Nop>'                  , {noremap = true})
vim.keymap.set('n', 'tn'      , ':<C-u>tabnew <C-R>%<CR>', {noremap = true})
vim.keymap.set('n', 't<LEFT>' , ':<C-u>tabprev<CR>'      , {noremap = true})
vim.keymap.set('n', 't<RIGHT>', ':<C-u>tabnext<CR>'      , {noremap = true})
vim.keymap.set('n', 'th'      , ':<C-u>tabprev<CR>'      , {noremap = true})
vim.keymap.set('n', 'tl'      , ':<C-u>tabnext<CR>'      , {noremap = true})
vim.keymap.set('n', 'tq'      , ':<C-u>tabclose<CR>'     , {noremap = true})

-- ウィンドウ関係
vim.keymap.set('n', '<C-w><C-l>', ':<C-u>vertical resize +5<CR>', {noremap = true})
vim.keymap.set('n', '<C-w><C-h>', ':<C-u>vertical resize -5<CR>', {noremap = true})
vim.keymap.set('n', '<C-w><C-k>', ':<C-u>resize +5<CR>'         , {noremap = true})
vim.keymap.set('n', '<C-w><C-j>', ':<C-u>resize -5<CR>'         , {noremap = true})

-- バッファ関係
vim.keymap.set('n', '<C-n>'      , ':<C-u>bprev<CR>', {noremap = true})
vim.keymap.set('n', '<C-p>'      , ':<C-u>bnext<CR>', {noremap = true})

-- コマンドモード: カレントファイルパス・ディレクトリ補完
vim.keymap.set('c', '<C-X>', "<C-r>=expand('%:p:h')<cr>/")
vim.keymap.set('c', '<C-Z>', "<C-r>=expand('%:p')<cr>")
