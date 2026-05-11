vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

pcall(vim.loader.enable)

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.colorscheme")
