-- neovim-native fuzzy finder
return {
  'nvim-telescope/telescope.nvim', 
  event = 'VimEnter', 
  branch = '0.1.x', 
  dependencies = { 
    'nvim-lua/plenary.nvim',

      -- TODO copied the ones below from teej, check them out
      -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- { "nvim-telescope/telescope-smart-history.nvim" },
      -- { "kkharji/sqlite.lua" },
      
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require "yvhn.telescope"
  end,
}
