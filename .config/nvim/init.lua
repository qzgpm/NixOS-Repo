-- 🚀 Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy").setup({
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto", globalstatus = true },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
})

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

-- Remove trailing white spaces
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
}
