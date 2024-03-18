-- ddc global settings ------------------------------------------------------------------------ {{{
vim.fn['ddc#custom#patch_global'](
  {
    ui = 'pum',
    sources = {'nvim-lsp'},
    sourceOptions = {
      _ = {
        matchers = {'matcher_fuzzy'},
        sorters = {'sorter_fuzzy'},
        converters = {'converter_fuzzy'},
      },
      around = {
        mark = '[A]',
      },
      ['nvim-lsp'] = {
        mark = '[L]',
        forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
      },
    },
  }
)
-- }}}

-- keymap ------------------------------------------------------------------------------------- {{{
vim.keymap.set('i', '<C-n>', '<cmd>call pum#map#insert_relative(+1)<cr>')
vim.keymap.set('i', '<C-p>', '<cmd>call pum#map#insert_relative(-1)<cr>')
vim.keymap.set('i', '<C-y>', '<cmd>call pum#map#confirm()<cr>')
vim.keymap.set('i', '<C-e>', '<cmd>call pum#map#cancel()<cr>')
vim.keymap.set('i', '<PageDown>', '<cmd>call pum#map#insert_relative_page(+1)<cr>')
vim.keymap.set('i', '<PageUp>', '<cmd>call pum#map#insert_relative_page(-1)<cr>')
-- }}}

-- 設定の有効化
vim.fn['ddc#enable']()
-- vim.fn['signature_help#enable']()  -- Vim:E117: 未知の関数です: signature_help#enable

