vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},

	formatting = {
		format = lspkind.cmp_format({
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
				gh_issues = "[issues]",
				tn = "[TabNine]",
			},
		}),
	},
})
