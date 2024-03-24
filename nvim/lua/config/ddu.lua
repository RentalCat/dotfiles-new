local M = {}

function M.config()
  -- ddu global settings ---------------------------------------------------------------------- {{{
  -- vim全体の行数・列数
  local lines = vim.opt.lines:get()
  local columns = vim.opt.columns:get()
  -- ddu のウィンドウサイズ設定
  local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
  local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)

  vim.fn['ddu#custom#patch_global'](
    {
      ui = 'ff',
      uiParams = {
        ff = {
          startFilter = true,
          prompt = '> ',
          split = 'floating',
          winHeight = height,
          winRow = row,
          winWidth = width,
          winCol = col,
          floatingBorder = 'single',
          filterFloatingPosition = 'top',
          autoAction = {
            name = 'preview',
          },
          startAutoAction = true,
          previewFloating = true,
          previewFloatingBorder = 'single',
          previewSplit = 'vertical',
          previewFloatingTitle = 'Preview',
          previewWidth = math.floor(width * 0.5),
          previewHeight = math.floor(height * 0.8),
          highlights = {
            floating = 'Normal',
            floatingBorder = 'Normal',
          },
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
          ignoreCase = true,
          matchers = {'matcher_substring'},
          sorters = {'sorter_alpha'},
        }
      },
      filterParams = {
        matcher_substring = {
          highlightMatched = 'Search',
        },
      },
      kindOptions = {
        file = {defaultAction = 'open'},
      }
    }
  )
  -- }}}

  --- ddu add keymap
  ---@param mode string
  ---@param lhs string
  ---@param action_func function
  local function ddu_akeymap(mode, lhs, action_func)
    return vim.keymap.set(
      mode,
      lhs,
      action_func,
      {silent = true, buffer = true}
    )
  end

  --- ddu add keymap (normal mode)
  ---@param lhs string
  ---@param action string
  local function ddu_nkeymap(lhs, action)
    return ddu_akeymap(
      'n',
      lhs,
      function()
        vim.fn['ddu#ui#do_action'](action)
      end
    )
  end

  --- ddu add keymap (insert mode)
  ---@param lhs string
  ---@param action string
  local function ddu_ikeymap(lhs, action)
    return ddu_akeymap(
      'i',
      lhs,
      function()
        vim.cmd('stopinsert')  -- stop insert mode
        vim.fn['ddu#ui#do_action'](action)
      end
    )
  end

  -- ddu ui ff settings ----------------------------------------------------------------------- {{{
  vim.api.nvim_create_augroup( 'ddu-ff-settings', {})
  vim.api.nvim_create_autocmd( 'FileType', {
    group = 'ddu-ff-settings',
    pattern = 'ddu-ff',
    callback = function()
      -- key setting
      ddu_nkeymap('<cr>' , 'itemAction')
      ddu_nkeymap('a'    , 'chooseAction')
      ddu_nkeymap('i'    , 'openFilterWindow')
      ddu_nkeymap('q'    , 'quit')
      ddu_nkeymap('<esc>', 'quit')
      ddu_nkeymap('<c-c>', 'quit')
      ddu_nkeymap('p'    , 'togglePreview')
      ddu_nkeymap('<C-j>', 'cursorNext')
      ddu_nkeymap('<C-k>', 'cursorPrevious')
    end
  })
  -- }}}
  -- ddu filter settings ---------------------------------------------------------------------- {{{
  vim.api.nvim_create_augroup( 'ddu-filter-settings', {})
  vim.api.nvim_create_autocmd( 'FileType', {
    group = 'ddu-filter-settings',
    pattern = 'ddu-ff-filter',
    callback = function()
      -- key setting
      ddu_ikeymap('<cr>' , 'closeFilterWindow')
      ddu_ikeymap('<c-c>', 'closeFilterWindow')
      ddu_ikeymap('<esc>', 'closeFilterWindow')
      ddu_nkeymap('<cr>' , 'closeFilterWindow')
      -- vim.keymap.set('i', '<esc>', '<cmd>call ddu#ui#do_action("closeFilterWindow")<cr><esc>', keyopts)
      -- vim.keymap.set('i', '<C-j>', [[<cmd>call ddu#ui#ff#execute("call cursor(line('.') + 1, 0)")<cr>]], keyopts)
      -- vim.keymap.set('i', '<C-h>', [[<cmd>call ddu#ui#ff#execute("call cursor(line('.') - 1, 0)")<cr>]], keyopts)
    end
  })
  -- }}}
end

function M.keys()
  local function dduRgCursorWord()
  vim.fn['ddu#start']({
    sources = {
      {
        name = 'rg',
        options = {
          -- matchers = {},
          volatile = false,
        },
       params = {
         input = vim.fn.expand('<cword>'),
         args = {'--json'},
       },
      },
    },
    uiParams = {
      ff = {
        floatingTitle = string.format('Ripgrep: "%s"', vim.fn.expand('<cword>')),
        ignoreEmpty = false,
        autoResize = false,
      },
    },
  })
  end

  return {
    -- ripgrep text
    {'<Leader>dg', '<cmd>DduRg<cr>', desc='ddu ripgrep' },
    -- ripgrep cursor word
    {'gv'        , dduRgCursorWord, desc='ddu ripgrep cursor word' },
    {'<Leader>db', '<cmd>call ddu#start(#{ sources: [#{ name: "buffer"}]})<cr>', desc='ddu buffer'},
    {'<Leader>dh', '<cmd>call ddu#start(#{ sources: [#{ name: "help"}]})<cr>'  , desc='ddu buffer'},
  }
end

return M
