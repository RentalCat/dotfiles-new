-- ddu global settings ------------------------------------------------------------------------ {{{
-- local columns = vim.api.nvim_eval('&columns')
-- local lines = vim.api.nvim_eval('&lines')
vim.fn['ddu#custom#patch_global'](
  {
    ui = 'ff',
    uiParams = {
      ff = {
        split = 'floating',
        floatingBorder = 'single',
        autoAction = {name = 'preview'},
        previewFloating = true,
        previewFloatingBorder = 'single',
      },
    },
    sources = {
      -- shun/ddu-source-buffer
      { name = 'buffer' },
      -- shun/ddu-source-rg
      {
        name = 'rg',
        params = {args = {'--json'}},
      },
    },
    sourceOptions = {
      _ = {
        matchers = {'matcher_fzf'},
        sorters = {'sorter_alpha'},
      }
    },
    filterParams = {
      matcher_fzf = {
        highlightMatched = 'Search',
      },
    },
    kindOptions = {
      file = {defaultAction = 'open'},
    }
  }
)
-- }}}


local keyopts = {silent = true, buffer = true}
-- ddu ui ff settings ------------------------------------------------------------------------- {{{
vim.api.nvim_create_augroup( 'ddu-ff-settings', {})
vim.api.nvim_create_autocmd( 'FileType', {
  group = 'ddu-ff-settings',
  pattern = 'ddu-ff',
  callback = function()
    -- key setting
    vim.keymap.set('n', '<cr>', '<cmd>call ddu#ui#do_action("itemAction")<cr>'      , keyopts)
    vim.keymap.set('n', 'a'   , '<cmd>call ddu#ui#do_action("chooseAction")<cr>'    , keyopts)
    vim.keymap.set('n', 'i'   , '<cmd>call ddu#ui#do_action("openFilterWindow")<cr>', keyopts)
    vim.keymap.set('n', 'q'   , '<cmd>call ddu#ui#do_action("quit")<cr>'            , keyopts)
    vim.keymap.set('n', 'p'   , '<cmd>call ddu#ui#do_action("preview")<cr>'         , keyopts)
    vim.keymap.set('n', '<C-j>', '<cmd>call ddu#ui#do_action("cursorNext")<cr>'      , keyopts)
    vim.keymap.set('n', '<C-k>', '<cmd>call ddu#ui#do_action("cursorPrevious")<cr>'  , keyopts)
  end
})
-- }}}
-- ddu filter settings ------------------------------------------------------------------------ {{{
vim.api.nvim_create_augroup( 'ddu-filter-settings', {})
vim.api.nvim_create_autocmd( 'FileType', {
  group = 'ddu-filter-settings',
  pattern = 'ddu-ff-filter',
  callback = function()
    -- key setting
    vim.keymap.set('i', '<cr>' , '<cmd>call ddu#ui#do_action("itemAction")<cr>'       , keyopts)
    vim.keymap.set('i', '<esc>', '<cmd>call ddu#ui#do_action("closeFilterWindow")<cr><esc>', keyopts)
    vim.keymap.set('i', '<C-j>', [[<cmd>call ddu#ui#ff#execute("call cursor(line('.') + 1, 0)")<cr>]], keyopts)
    vim.keymap.set('i', '<C-h>', [[<cmd>call ddu#ui#ff#execute("call cursor(line('.') - 1, 0)")<cr>]], keyopts)
  end
})
-- }}}
