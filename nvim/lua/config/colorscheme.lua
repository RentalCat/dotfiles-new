-- カラースキーマ適応
vim.cmd('colorscheme molokai')
-- 非表示文字(行末の空白など)の色を設定
vim.cmd('highlight NonText ctermfg=236 gui=bold guifg=#213033')
-- Diff色を設定
--vim.cmd('highlight DiffAdd ctermbg=24 guibg=#238636')
vim.cmd('highlight DiffAdd    ctermfg=None ctermbg=35  guifg=None guibg=#2ea043')
vim.cmd('highlight DiffChange ctermfg=None ctermbg=22  guifg=None guibg=#196c2e')
vim.cmd('highlight DiffDelete ctermfg=None ctermbg=124 guifg=None guibg=#b62324')
vim.cmd('highlight DiffText   ctermfg=None ctermbg=94  guifg=None guibg=#845306')
