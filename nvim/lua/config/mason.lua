-- mason 設定
require('mason').setup()

-- mason <-> lspconfig 中継モジュール設定
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()

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
local lspconfig = require('lspconfig')
mason_lspconfig.setup_handlers({
  -- default LSP settings
  function(server_name)
    local opts = {on_attach = on_attach}
    lspconfig[server_name].setup(opts)
  end,
  -- lua (for vim settings)
  lua_ls = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    })
  end,
  -- python
  pylsp = function()
    lspconfig.pylsp.setup({
      settings = {
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
      },
    })
  end,
})

-- Formatter, Linter 設定
local null_ls = require("null-ls")
local mason_package = require("mason-core.package")
local null_sources = {}
for _, package in ipairs(require('mason-registry').get_installed_packages()) do
  local package_categories = package.spec.categories[1]
  if package_categories == mason_package.Cat.Formatter then
    table.insert(null_sources, null_ls.builtins.formatting[package.name])
  end
end
null_ls.setup(null_sources)


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
