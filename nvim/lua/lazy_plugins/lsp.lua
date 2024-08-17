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

			local lspconfig = require("lspconfig")

			local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
			emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- FIXME ideally this path should be fetched dynamically like so:
			-- ```
			-- local mason_registry = require("mason-registry")
			-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()
			-- ```
			-- but it currently cannot find the package by that name.
			-- (source: https://github.com/vuejs/language-tools/blob/0e52a2d21fdd7c68447b7cd3d5c06876762cdc8b/README.md?plain=1#L40)
			--
			-- for now the workaround way to get it is to run `npm list -g --depth=0` and copy the path here
			local vue_language_server_path =
				"/Users/y.orlov/.nvm/versions/node/v18.20.2/lib/node_modules/@vue/language-server"

			local servers = {
				bashls = true,
				cssls = true,
				gopls = true,
				lua_ls = true,
				prismals = true,
				rust_analyzer = true,
				tailwindcss = true,
				volar = true, -- runs in tandem with tsserver (https://github.com/vuejs/language-tools/blob/0e52a2d21fdd7c68447b7cd3d5c06876762cdc8b/README.md?plain=1#L33)

				tsserver = {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vue_language_server_path,
								languages = { "vue" },
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

				eslint = {
					-- TODO is still needed? how does it interact with conform?
					---@diagnostic disable-next-line: unused-local
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
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
				"stylua",
				"lua_ls",
				"shfmt",
				-- "delve",
				-- "tailwind-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend(
					"force",
					{},
					{ -- TODO which one is overriden via `force`? emmet needs custom capabilities
						capabilities = capabilities,
					},
					config
				)

				lspconfig[name].setup(config)
			end

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

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			-- Autoformatting Setup
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					bash = { "shfmt" },
					vue = { "eslint", "prettier" },
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
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})
		end,
	},
}
