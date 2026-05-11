local opt = vim.opt

-- UI
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.termguicolors  = true
opt.showmatch      = true
opt.wrap           = false
opt.scrolloff      = 10
opt.sidescrolloff  = 8
opt.splitbelow     = true
opt.splitright     = true
opt.synmaxcol      = 240
opt.showmode       = false
opt.pumheight      = 10

-- Timing
opt.updatetime = 200
opt.timeoutlen = 300

-- Editing
opt.tabstop     = 2
opt.shiftwidth  = 2
opt.softtabstop = 2
opt.expandtab   = true
opt.smartindent = true
opt.undofile    = true
opt.swapfile    = false
opt.autoread    = true
opt.autowrite   = false
opt.clipboard   = "unnamedplus"

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- Completion
opt.completeopt = "menu,menuone,noinsert"
