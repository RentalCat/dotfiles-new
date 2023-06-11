-- NOTICE: event memo ========================================================================= {{{
-- VaryLazy: LazyDone が終わった後の VimEnter イベント
-- }}}
return {
  defaults = {lazy = true},

  -- colorscheme ------------------------------------------------------------------------------ {{{
  {
    'tomasr/molokai',
    lazy = false,  -- カラースキーマは lazy=false
    priority = 1000,  -- カラースキーマは高めに設定するらしい
    config = function()
      require('config/colorscheme')
    end
  },
  -- }}}

  -- LSP(Language Server Protocol)・自動補完関係 ---------------------------------------------- {{{
  { -- mason: LSP(Language Server Protocol), DAP, Linter, Formatter 管理ツール
    'williamboman/mason.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',              -- LSP クライアント設定プラグイン
      'williamboman/mason-lspconfig.nvim',  -- lsp-config と mason の橋渡し用
    },
    --event = "InsertEnter",
    config = function()
      require('config/mason')
    end,
  },
  { -- LSPの稼働状況をクールなアニメーションで通知してくれるプラグイン
    'j-hui/fidget.nvim',
    tag = 'legacy',  -- このプラグインはまもなく書き直されるらしい、変更されるまで legacy タグをつけておく
    dependencies = {
      'neovim/nvim-lspconfig',              -- LSP クライアント設定プラグイン
    },
    event = 'BufEnter',
    config = function()
      require('fidget').setup()
    end,
  },
  { -- Dark deno-powered completion framework (deopleteの後続)
    'Shougo/ddc.vim',
    dependencies = {
      'vim-denops/denops.vim',              -- Deno wrapper (Deno: JS & TypeScriptのランタイム環境)
      'matsui54/denops-popup-preview.vim',  -- 補完時にドキュメントを表示
      'matsui54/denops-signature_help',     -- LSPサーバからシグネチャのヘルプを表示してくれる (関数の引数一覧など)
      'Shougo/pum.vim',                     -- 魔王謹製の独自補完ウィンドウ
      'Shougo/ddc-ui-pum',                  -- UI     : pum UI
      'Shougo/ddc-source-nvim-lsp',         -- source : LSP (Language Server Protocol) 補完 (各言語は別で設定が必要)
      'tani/ddc-fuzzy',                     -- matcher: fuzzy検索・ソートができるように
      'Shougo/ddc-converter_remove_overlap',-- matcher: 補完候補の重複を消すfilter
    },
    event = 'InsertEnter',
    config = function()
      require('config/ddc')
    end,
  },
  -- }}}

  -- ステータスライン関係 --------------------------------------------------------------------- {{{
  { -- lualine
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',  -- ステータスライン上にファイルアイコンを表示できるように
    },
    config = function()
      require('config/lualine')
    end,
  },
  -- }}}

  -- UI追加関係 ------------------------------------------------------------------------------- {{{
  { -- Dark deno-powered ui framework (deniteの後続)
    'Shougo/ddu.vim',
    dependencies = {
      'vim-denops/denops.vim',           -- Deno wrapper (Deno: JS & TypeScriptのランタイム環境)
      'Shougo/ddu-ui-ff',                -- UI    : fuzzy finder
      'shun/ddu-source-buffer',          -- source: buffer一覧
      'shun/ddu-source-rg',              -- source: ファイル横断の文字列検索
      'matsui54/ddu-source-help',        -- source: help
      'yuki-yano/ddu-filter-fzf',        -- filter: fzfフィルター
      'Shougo/ddu-filter-sorter_alpha',  -- sorter: alphabet sorter
      'Shougo/ddu-kind-file',            -- kind  : fileに対してのアクションを定義
    },
    keys = {
      {'<Leader>dg', '<cmd>DduRg<cr>'                                            , desc='ddu ripgrep'},
      {'<Leader>db', '<cmd>call ddu#start({"sources": [{"name": "buffer"}]})<cr>', desc='ddu buffer'},
      {'<Leader>dh', '<cmd>call ddu#start({"sources": [{"name": "help"}]})<cr>'  , desc='ddu buffer'},
    },
    config = function()
      require('config/ddu')
    end,
  },
  { -- スクロールバー表示
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end,
  },
  -- }}}

  -- 補完関係 --------------------------------------------------------------------------------- {{{
  { -- Github Copilot
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup(
        {
          suggestion = {
            auto_trigger = true,
            keymap = {
              accept = '<Right>',
              next = '<M-n>',
              prev = '<M-p>',
            },
          },
        }
      )
    end,
  },
  -- }}}

  -- ファイル操作関係 ------------------------------------------------------------------------- {{{
  { -- ファイラー本体
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/nerdfont.vim',                -- nerdfontプラグイン本体
      'lambdalisue/glyph-palette.vim',           -- nerdfont色つけ用
      'lambdalisue/fern-renderer-nerdfont.vim',  -- nerdfont fern を描画
      'yuki-yano/fern-preview.vim',              -- プレビュー表示プラグイン
      'lambdalisue/fern-git-status.vim',         -- gitステータス表示プラグイン
      'lambdalisue/fern-mapping-git.vim',        -- gitステータス変更
      'lambdalisue/fern-hijack.vim',             -- ハイジャック ('vim .' でfern起動)
    },
    lazy = false,  -- git-status, hijackを有効にするため lazy=false
    keys = {
      {'<Leader>f', '<cmd>Fern . -reveal=%<cr>', desc='Fern'},
    },
    config = function()
      require('config/fern')
    end,
  },
  -- Git関連 ---------------------------------------------------------------------------------- {{{
  -- { -- Git管理ツール
  --   'lambdalisue/gin.vim',
  --   dependencies = {
  --     'vim-denops/denops.vim',  -- Deno wrapper (Deno: JS & TypeScriptのランタイム環境)
  --   },
  --   cmd = 'Gin',
  --   keys = {
  --     {'<Leader>gs', '<cmd>GinStatus<cr>', desc='Gin'},
  --   },
  -- },
  { -- Git diff
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',  -- ファイルアイコンを表示できるように
    },
    config = function()
      require('config/diffview')
    end,
  },
  { -- 行表示の横に差分表記追加 (vim-gitgutterの進化版)
    'lewis6991/gitsigns.nvim',
    config = function()
      require('config/gitsigns')
    end,
  },
  -- }}}

  -- 標準拡張系 ------------------------------------------------------------------------------- {{{
  { -- diffの差分を文字単位で表示する
    'rickhowe/diffchar.vim',
  },
  { -- 単語検索拡張
    'easymotion/vim-easymotion',
    keys = {
      {',', '<Plug>(easymotion-s2)'},
      {'/', '<Plug>(easymotion-sn)'},
      {'f', '<Plug>(easymotion-fl)'},
      {'F', '<Plug>(easymotion-Fl)'},
    },
    config = function()
      vim.api.nvim_set_var('EasyMotion_do_mapping', 0)  -- オリジナルマッピング有効
    end,
  },
  { -- インデントライン追加
    'lukas-reineke/indent-blankline.nvim',
  },
  { -- 単語マーキング
    't9md/vim-quickhl',
    keys = {
      {'<Leader>m', '<Plug>(quickhl-manual-this-whole-word)'},
      {'<Leader>m', '<Plug>(quickhl-manual-this)', mode = 'x'},
      {'<Esc><Esc>', '<Plug>(quickhl-manual-reset):<C-u>nohlsearch<CR><Esc>'},
    },
  },
  { -- ノーマルモード遷移時にIMEを自動でオフ, インサートモード遷移時にIMEの状態を復元 (要 im-select コマンド)
    'yoshida-m-3/vim-im-select',
  },
  -- }}}
}
