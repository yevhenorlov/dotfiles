-- neovim-native fuzzy finder
return {
  'nvim-telescope/telescope.nvim', 
  event = 'VimEnter', 
  branch = '0.1.x', 
  dependencies = { 
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  }
}
