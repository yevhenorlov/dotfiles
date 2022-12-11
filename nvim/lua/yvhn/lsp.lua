local buf_nnoremap = require("yvhn.keymap").buf_nnoremap
require'lspconfig'.volar.setup{ -- vue, npm install -g @volar/vue-language-server
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  on_attach = function()
    buf_nnoremap("K",vim.lsp.buf.hover)
    buf_nnoremap("gr",vim.lsp.buf.references)
    buf_nnoremap("gd",vim.lsp.buf.definition)
    buf_nnoremap("gt",vim.lsp.buf.type_definition)
    buf_nnoremap("gi",vim.lsp.buf.implementation)
    -- TODO completion
    buf_nnoremap("gD","<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>")
    buf_nnoremap("gT","<cmd>vs<CR><cmd>lua vim.lsp.buf.type_definition()<CR>")
    buf_nnoremap("gI","<cmd>vs<CR><cmd>lua vim.lsp.buf.implementation()<CR>")
    buf_nnoremap("]c", vim.diagnostic.goto_next)
    buf_nnoremap("[c", vim.diagnostic.goto_prev)
    -- TODO :Telescope diagnostic
    buf_nnoremap("<localleader>r", vim.lsp.buf.rename)
    buf_nnoremap("<localleader>a", vim.lsp.buf.code_action)
  end,
} 

