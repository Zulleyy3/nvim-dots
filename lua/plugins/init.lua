return {
-- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  --tpope/vim-rhubarb', --I don't really need github specific stuff rn

  -- -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',



  -- Useful plugin to show you pending keybinds. (Probably good for learning it proper, lets leave them here)
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'powerline',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    -- TODO figure out what i like for this
    opts = {
      scope = {
        enabled = false,
        char = 'L',
        show_start = false,
      },
      indent = {
        char = '|',
      }
      -- show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'lervag/vimtex',
    lazy=false,
    init = function ()
      vim.g.vimtex_matchparen_enabled=0
      vim.g.vimtex_syntax_nospell_comments = 1
      vim.g.vimtex_view_method="zathura"
      vim.keymap.set("n", "<leader>tv", "<cmd>VimtexTocToggle<CR>", {desc = "Toggle [v]imtex table of contents"})
      -- vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
      -- vim.g.vimtex_view_general_viewer = 'okular'
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    'nmac427/guess-indent.nvim',
    config = function ()
        require("guess-indent").setup {}
    end
  },
  -- -- Debug Adapter
  -- { "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --       "mfussenegger/nvim-dap",
  --       "nvim-neotest/nvim-nio"
  --   }
  -- },
  --
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },

  require("plugins.complex.telescope");
  require("plugins.complex.aerial");
  require("plugins.complex.lsp");
  require("plugins.complex.treesitter");
  require("plugins.complex.nvim-cmp_luasnip");
  require("plugins.complex.debugger");

}

