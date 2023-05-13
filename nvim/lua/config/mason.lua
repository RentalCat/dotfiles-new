-- mason 設定
require('mason').setup()

-- LSP: 各言語ごとにセットアップ
local nvim_lsp = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup_handlers(
  {
    function(server_name)
      local opts = {}

      -- lua (for vim settings)
      if server_name == 'lua-language-server' then
        opts.settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
          },
        }
      end

      nvim_lsp[server_name].setup(opts)
    end
  }
)
