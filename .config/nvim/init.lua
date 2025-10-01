-- Options
vim.o.number  = true
vim.o.relativenumber  = true
vim.o.swapfile  = false
vim.o.wrap  = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.autoread  = true
vim.o.autowrite = false
vim.opt.clipboard:append("unnamedplus")

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth  = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- Keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>", {desc = "Spelling"})

-- Theme
vim.cmd.colorscheme("vim");
vim.api.nvim_set_hl(0,"Normal", {bg ="none"})
vim.api.nvim_set_hl(0,"NormalNC", {bg ="none"})
vim.api.nvim_set_hl(0,"EndofBuffer", {bg ="none"})

-- Search
vim.o.ignorecase  = true
vim.o.smartcase = true

-- Visual
vim.o.termguicolors = true
vim.o.showmatch = true

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Auto-pair brackets
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "\"", "\"\"<Left>")
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", "`", "``<Left>")

-- Remove trailing white spaces
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
