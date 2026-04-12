# Improvements

## Neovim startup performance — lazy loading

Plugins currently loading at startup that could be deferred:

| Plugin | File | Change | When to load |
|--------|------|--------|--------------|
| LSP stack (lspconfig, mason, conform, fidget) | `lazy_plugins/lsp.lua` | add `event = "BufReadPre"` | first buffer open |
| nvim-cmp | `lazy_plugins/completion.lua` | `event = "InsertEnter"` instead of `lazy=false` | entering insert mode |
| telescope | `lazy_plugins/telescope.lua` | `keys = {...}` instead of `event = "VimEnter"` | first keypress |
| treesitter | `lazy_plugins/treesitter.lua` | `event = "BufReadPre"` | first buffer open |
| fugitive | `lazy_plugins/fugitive.lua` | `cmd = { "Git", "G" }` | git command invoked |
| gitsigns | `lazy_plugins/gitsigns.lua` | `event = "BufReadPre"` | first buffer open |
| harpoon | `lazy_plugins/harpoon.lua` | `keys = {...}` | first keypress |
| oil | `lazy_plugins/oil.lua` | `keys` or `cmd = "Oil"` | command/keypress |
| duck | `lazy_plugins/duck.lua` | `keys = {...}` | first keypress |

**Skip:** `theme` (must load first, `priority=1000`), `mini` (statusline/pairs need to be immediate).
