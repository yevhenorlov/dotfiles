lua << EOF
-- server list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- for inspiration, ThePrimeagen config: https://github.com/ThePrimeagen/.dotfiles/blob/7cf9cdf7996010ae135fa81b5e54989796a8848c/nvim/.config/nvim/after/plugin/lsp.lua
require'lspconfig'.tsserver.setup{}
-- require'lspconfig'.rust_analyzer.setup{}
EOF
