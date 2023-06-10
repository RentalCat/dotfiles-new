-- mason 設定
require('mason').setup()

-- Reference highlight (カーソル上の変数をハイライトする)
local on_attach = function(client, _)
  if client.server_capabilities.document_highlight then
    local reference_highlight = 'cterm=underline ctermfg=15 ctermbg=8 gui=underline guifg=#ffffff guibg=#104040'
    vim.cmd.highlight({'LspReferenceRead', reference_highlight})
    vim.cmd.highlight({'LspReferenceWrite', reference_highlight})
    vim.api.nvim_create_augroup('lsp-reference-highlight', {})
    vim.api.nvim_create_autocmd(
      {'CursorHold', 'CursorHoldI'},
      {
        group = 'lsp-reference-highlight',
        callback = vim.lsp.buf.document_highlight,
      }
    )
    vim.api.nvim_create_autocmd(
      {'CursorMoved', 'CursorMovedI'},
      {
        group = 'lsp-reference-highlight',
        callback = vim.lsp.buf.clear_references,
      }
    )
  end
end

-- LSP: 各言語ごとにセットアップ
local nvim_lsp = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup_handlers(
  {
    function(server_name)
      local opts = {on_attach = on_attach}
      -- print(server_name)

      if server_name == 'lua_ls' then
        -- lua (for vim settings)
        opts.settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
          },
        }
      elseif server_name == 'pylsp' then
        -- python
        opts.settings = {
          pylsp = {
            plugins = {
              pycodestyle = {  -- 旧pep8, flake8に内包されているため不要
                enabled = false,
              },
              autopep8 = { enabled = false },
              pyflakes = { enabled = false },
              flake8 = {
                enabled = true,
              },
            },
          },
        }
      end

      nvim_lsp[server_name].setup(opts)
    end
  }
)

-- keymaps
vim.keymap.set('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>')


vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
