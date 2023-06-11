-- カラースキーマ適応
vim.cmd('colorscheme molokai')
-- 非表示文字(行末の空白など)の色を設定
vim.cmd('highlight NonText ctermfg=236 gui=bold guifg=#213033')
-- カーソル上括弧の色を設定 (molokaiと文字色・背景を逆に設定)
vim.cmd('highlight MatchParen cterm=bold ctermfg=233 ctermbg=208 gui=bold guifg=#fd971f guibg=#000000')
-- Diff色を設定
vim.cmd('highlight DiffAdd    ctermfg=None ctermbg=22  guifg=None    guibg=#04260f')
vim.cmd('highlight DiffChange ctermfg=None ctermbg=22  guifg=None    guibg=#051d4d')
vim.cmd('highlight DiffDelete ctermfg=None ctermbg=52  guifg=None    guibg=#490202')
--vim.cmd('highlight DiffDelete ctermfg=236  ctermbg=0   guifg=#213033 guibg=#000000')
vim.cmd('highlight DiffText   ctermfg=None ctermbg=94  guifg=None    guibg=#845306')
