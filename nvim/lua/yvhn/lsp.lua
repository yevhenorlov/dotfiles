-- server list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- for inspiration, ThePrimeagen config: https://github.com/ThePrimeagen/.dotfiles/blob/7cf9cdf7996010ae135fa81b5e54989796a8848c/nvim/.config/nvim/after/plugin/lsp.lua

local buf_nnoremap = require("yvhn.keymap").buf_nnoremap
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function bootstrap_shared_bindings()
  buf_nnoremap("K",vim.lsp.buf.hover)
  buf_nnoremap("gr",vim.lsp.buf.references)
  buf_nnoremap("gd",vim.lsp.buf.definition)
  buf_nnoremap("gt",vim.lsp.buf.type_definition)
  buf_nnoremap("gi",vim.lsp.buf.implementation)
  buf_nnoremap("gD","<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>")
  buf_nnoremap("gT","<cmd>vs<CR><cmd>lua vim.lsp.buf.type_definition()<CR>")
  buf_nnoremap("gI","<cmd>vs<CR><cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_nnoremap("]c", vim.diagnostic.goto_next)
  buf_nnoremap("[c", vim.diagnostic.goto_prev)
  -- TODO :Telescope diagnostic
  buf_nnoremap("<localleader>r", vim.lsp.buf.rename)
  buf_nnoremap("<localleader>a", vim.lsp.buf.code_action)
end

-- SETUP

-- TODO fix startup errors in react ts files
require'lspconfig'.volar.setup{ -- vue, npm install -g @volar/vue-language-server
capabilites = capabilites,
filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
on_attach = function()
  bootstrap_shared_bindings()
end,
} 

require'lspconfig'.tsserver.setup{
capabilites = capabilites,
on_attach = function()
  bootstrap_shared_bindings()
end,
}

require'lspconfig'.tailwindcss.setup{
capabilites = capabilites,
}

