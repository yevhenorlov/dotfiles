-- server list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- for inspiration, ThePrimeagen config: https://github.com/ThePrimeagen/.dotfiles/blob/7cf9cdf7996010ae135fa81b5e54989796a8848c/nvim/.config/nvim/after/plugin/lsp.lua

local buf_nnoremap = require("yvhn.keymap").buf_nnoremap
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function bootstrap_config()
  buf_nnoremap("K",vim.lsp.buf.hover)
  buf_nnoremap("gr",vim.lsp.buf.references)
  buf_nnoremap("gd",vim.lsp.buf.definition)
  buf_nnoremap("gt",vim.lsp.buf.type_definition)
  buf_nnoremap("gi",vim.lsp.buf.implementation)
  buf_nnoremap("gD","<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>")
  buf_nnoremap("gT","<cmd>vs<CR><cmd>lua vim.lsp.buf.type_definition()<CR>")
  buf_nnoremap("gI","<cmd>vs<CR><cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_nnoremap("]d", vim.diagnostic.goto_next)
  buf_nnoremap("[d", vim.diagnostic.goto_prev)
  vim.diagnostic.config({virtual_text = false})
  buf_nnoremap("<localleader>r", vim.lsp.buf.rename)
  buf_nnoremap("<localleader>a", vim.lsp.buf.code_action)
  buf_nnoremap("<localleader>f", vim.lsp.buf.format)
end

-- SETUP

require'lspconfig'.volar.setup{ -- vue, npm install -g @volar/vue-language-server
capabilites = capabilites,
-- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}, -- takeover mode, kinda breaks other projects. more info: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
on_attach = function()
  bootstrap_config()
end,
} 

require'lspconfig'.tsserver.setup{
capabilites = capabilites,
on_attach = function()
  bootstrap_config()
end,
}

require'lspconfig'.tailwindcss.setup{
capabilites = capabilites,
}

require'lspconfig'.cssls.setup{ -- npm i -g vscode-langservers-extracted
capabilites = capabilites,
on_attach = function()
  bootstrap_config()
end,
}

require'lspconfig'.rust_analyzer.setup{ -- https://rust-analyzer.github.io/manual.html#installation
capabilites = capabilites,
on_attach = function()
  bootstrap_config()
end,
}

local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = emmet_capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

-- FORMATTING

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.prettier,
  },
  on_attach = function(client)
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end
})

-- LINTING

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
-- require'lspconfig'.eslint.setup{}
require'lspconfig'.eslint.setup{
   on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
