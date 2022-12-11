vim.opt.completeopt = {"menu", "menuone", "noselect"} 
-- docs:
-- https://github.com/hrsh7th/cmp-path#configuration
--
--
-- Set up nvim-cmp.
local cmp = require'cmp'
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      symbol_map = {
        Text = "💬",
        Method = "💡",
        Function = "🔨",
        Constructor = "🏭",
        Field = "🚜",
        Variable = "📦",
        Class = "🏫",
        Interface = "🎛",
        Module = "🗃",
        Property = "🐽",
        Unit = "⏲️",
        Value = "💯",
        Enum = "🔢",
        Keyword = "🔑",
        Snippet = "📎",
        Color = "🎨",
        File = "📁",
        Reference = "📚",
        Folder = "📂",
        EnumMember = "#️⃣",
        Constant = "🗿",
        Struct = "🚧",
        Event = "🎉",
        Operator = "➕",
        TypeParameter = "🔢",
      },
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
      },
    },
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Enter>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- nb! order here sets completion priority
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer', keyword_length = 5 },
  })
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })

