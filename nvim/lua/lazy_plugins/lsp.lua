-- Configurations for Nvim LSP
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("neodev").setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if pcall(require, "cmp_nvim_lsp") then
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			end

			local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
			emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- mason-registry.get_package("vue-language-server"):get_install_path() would be cleaner
			-- but fails at config time due to async registry initialization. Mason always installs
			-- to stdpath("data")/mason/packages/, so this is equivalent without the async issue.
			local vue_language_server_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			local servers = {
				bashls = true,
				cssls = true,
				gopls = true,
				lua_ls = true,
				prismals = true,
				rust_analyzer = true,
				tailwindcss = true,
				vue_ls = true, -- runs in tandem with vtsls (https://github.com/vuejs/language-tools/wiki/Neovim)

				vtsls = {
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_language_server_path,
										languages = { "vue" },
										configNamespace = "typescript",
									},
								},
							},
						},
					},
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				},

				emmet_ls = {
					capabilities = emmet_capabilities,
					filetypes = {
						"css",
						"eruby",
						"html",
						"javascript",
						"javascriptreact",
						"less",
						"sass",
						"scss",
						"svelte",
						"pug",
						"typescriptreact",
						"vue",
					},
					init_options = {
						html = {
							options = {
								-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
								["bem.enabled"] = true,
							},
						},
					},
				},

				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"eslint_d",
				"lua_ls",
				"prettierd",
				"shfmt",
				"stylua",
				-- "delve",
				-- "tailwind-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup()

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)

				vim.lsp.config(name, config)
			end
			-- automatically install ensure_installed servers
			vim.lsp.enable(vim.tbl_keys(servers))

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

					local buf_nnoremap = require("yvhn.keymap").buf_nnoremap
					buf_nnoremap("gd", vim.lsp.buf.definition)
					buf_nnoremap("gr", vim.lsp.buf.references)
					buf_nnoremap("gD", vim.lsp.buf.declaration)
					buf_nnoremap("gT", vim.lsp.buf.type_definition)
					buf_nnoremap("K", vim.lsp.buf.hover)
					buf_nnoremap("<localleader>r", vim.lsp.buf.rename)
					buf_nnoremap("<localleader>a", vim.lsp.buf.code_action)
					buf_nnoremap("<localleader>f", vim.lsp.buf.format)
					buf_nnoremap("<localleader>cp", '<cmd>let @+ = expand("%:~")<cr>') -- copy path to current buffer (:~ replaces home dir with ~)
					local buf_vnoremap = require("yvhn.keymap").buf_vnoremap
					buf_vnoremap("<localleader>cp", function()
						-- "v" marks the selection anchor, "." is the cursor —
						-- swap if selection was made bottom-to-top
						local s_line = vim.fn.line("v")
						local e_line = vim.fn.line(".")
						local s_col = vim.fn.col("v")
						local e_col = vim.fn.col(".")
						if s_line > e_line or (s_line == e_line and s_col > e_col) then
							s_line, e_line = e_line, s_line
							s_col, e_col = e_col, s_col
						end
						local path = vim.fn.expand("%:~") -- :~ replaces home dir with ~
						local range
						if vim.fn.mode() == "V" then
							-- linewise (V): cols are always 1/EOL, omit them
							-- → /path/to/file.lua:10-20
							range = s_line .. "-" .. e_line
						else
							-- charwise (v): include col positions
							-- → /path/to/file.lua:10:5-20:15
							range = s_line .. ":" .. s_col .. "-" .. e_line .. ":" .. e_col
						end
						vim.fn.setreg("+", path .. ":" .. range)
					end) -- copy path with line or char range

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					require("lint").try_lint()
				end,
			})

			-- Linting Setup
			require("lint").linters_by_ft = {
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				vue = { "eslint_d" },
			}

			-- Autoformatting Setup
			require("conform").setup({
				formatters_by_ft = {
					bash = { "shfmt" },
					lua = { "stylua" },
					typescript = { "eslint_d", "prettierd" },
					typescriptreact = { "eslint_d", "prettierd" },
					javascript = { "eslint_d", "prettierd" },
					vue = { "eslint_d", "prettierd" },
					go = { "goimports", "gofmt" },
					markdown = { "prettierd" },
					-- Conform will run multiple formatters sequentially, e.g.:
					-- python = { "isort", "black" },
					-- Use a sub-list to run only the first available formatter, e.g.:
					-- javascript = { { "prettierd", "prettier" } },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_format = "fallback",
						quiet = false,
						timeout_ms = 2000,
					})
				end,
			})

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft` for the current filetype
					require("lint").try_lint()
				end,
			})
		end,
	},
}
