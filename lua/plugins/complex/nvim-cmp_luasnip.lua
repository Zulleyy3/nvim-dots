return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Filepath completion
    'FelipeLema/cmp-async-path',

    -- Emoji (idk sometimes it's nice to meme with them)
    'hrsh7th/cmp-emoji',

    -- Adds a number of user-friendly snippets
    -- 'rafamadriz/friendly-snippets',
    'micangl/cmp-vimtex',
  },
    -- [[ Configure nvim-cmp ]]
  config = function ()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_lua').lazy_load({paths = "~/.config/nvim/lua/plugins/LuaSnip/"})
    luasnip.log.set_loglevel("debug")
    luasnip.config.set_config({ -- Setting LuaSnip config
      -- Enable autotriggered snippets
      enable_autosnippets = true,
      -- Use Tab (or some other key if you prefer) to trigger visual selection
      store_selection_keys = "<Tab>",
      update_events = "TextChanged,TextChangedI",

    })
    local mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<C-q>'] = cmp.mapping.abort(),
      -- ['<C-n>'] = cmp.mapping.select_next_item(),
      -- ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- elseif luasnip.expand_or_locally_jumpable() then
        --   luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-e>'] = cmp.mapping(function(fallback)
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          else
            fallback()
          end
        end, {'i', 's'}),
    }

    ---@diagnostic disable-next-line missing-fields
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = mapping,
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'async-path' },
        { name = 'emoji' },
      },
    }
    cmp.setup.filetype("tex", {
      sources = {
        { name = 'vimtex' },
        { name = 'buffer' },
        { name = 'luasnip' },
      },
    })
  end
}
