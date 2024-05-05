-- must happen before plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require('lazy_plugins');
require('yvhn');

require'fidget'.setup{}


