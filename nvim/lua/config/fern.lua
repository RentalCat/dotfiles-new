-- nerdfont表示
vim.g['fern#renderer'] = 'nerdfont'

-- バッファ操作関係の設定
vim.g['fern#keepalt_on_edit'] = 1    -- keepalt有効 (代理バッファ名を変更しないように見せかける)
vim.g['fern#keepjumps_on_edit'] = 1  -- keepjamps有効 (jumplistを変更しないように見せかける)

-- fean 画面中にキーバインドを追加
local keyopts = {silent = true, buffer = true}
local expr_keyopts = {buffer = true, expr = true, remap = true}
vim.api.nvim_create_augroup( 'fern-settings', {} )
vim.api.nvim_create_autocmd( 'FileType', {
  group = 'fern-settings',
  pattern = 'fern',
  callback = function()
    -- glyph palette 有効
    vim.fn['glyph_palette#apply']()
    -- <Leader>f 再度押下でクローズ (バッファ戻す)
    vim.keymap.set('n', '<Plug>(fern-my-fern-buffer-toggle)', '":<c-u>bprev<cr>"', expr_keyopts)
    vim.keymap.set('n', '<Leader>f' , '<Plug>(fern-my-fern-buffer-toggle)' , keyopts)
    vim.keymap.set('n', 'q'         , '<Plug>(fern-my-fern-buffer-toggle)' , keyopts)
    -- ファイル/フォルダの展開/折りたたみ (keymap.setだとなんかうまく行かなかったのでcmdで設定) {{{
    vim.cmd([[
      nmap <buffer><expr>
      \ <Plug>(fern-my-open-or-expand-or-collapse)
      \ fern#smart#leaf(
      \   "<Plug>(fern-action-open)",
      \   "<Plug>(fern-action-expand:stay)",
      \   "<Plug>(fern-action-collapse)",
      \ )
    ]])  -- }}}
    vim.keymap.set('n', '<CR>' , '<Plug>(fern-my-open-or-expand-or-collapse)'  , keyopts)
    -- 隠しファイル折りたたみ
    vim.keymap.set('n', 'i'    , '<Plug>(fern-action-hidden:toggle) '          , keyopts)
    -- プレビュー関係
    vim.keymap.set('n', 'p'    , '<Plug>(fern-action-preview:auto:toggle)'     , keyopts)
    vim.keymap.set('n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)'     , keyopts)
    vim.keymap.set('n', '<C-d>', '<Plug>(fern-action-preview:scroll:down:half)', keyopts)
    vim.keymap.set('n', '<C-u>', '<Plug>(fern-action-preview:scroll:up:half)'  , keyopts)
    --vim.keymap.set('n', 'p'    , '<Plug>(fern-action-preview:toggle)'          , keyopts)
  end
})

-- カラースキーマ変更
vim.cmd.highlight({'FernBranchText', 'ctermfg=118 guifg=#a6e22e'})         -- フォルダ文字色
vim.cmd.highlight({'FernGitStatusIndex', 'ctermfg=118 guifg=#a6e22e'})     -- git status (changes to be committed)
vim.cmd.highlight({'FernGitStatusWorktree', 'ctermfg=161 guifg=#f92672'})  -- git status (untracked & not staged)
