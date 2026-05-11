local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs,
    vim.tbl_extend("force", { silent = true }, opts or {}))
end

-- Better indenting in visual mode
map("v", "H", "<gv",             { desc = "Indent left" })
map("v", "L", ">gv",             { desc = "Indent right" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Toggle spelling
map("n", "<leader>os", "<cmd>setlocal spell! spelllang=en_us<CR>",
  { desc = "Toggle spelling" })

-- FZF
map("n", "<leader>f", "<cmd>Files<CR>",    { desc = "Find files" })
map("n", "<leader>g", "<cmd>Rg<CR>",       { desc = "Live grep" })
map("n", "<leader>b", "<cmd>Buffers<CR>",  { desc = "Buffers" })
map("n", "<leader>c", "<cmd>Commands<CR>", { desc = "Commands" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Resize splits
map("n", "<C-Up>",    "<cmd>resize +2<CR>")
map("n", "<C-Down>",  "<cmd>resize -2<CR>")
map("n", "<C-Left>",  "<cmd>vertical resize +2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize -2<CR>")

-- Keep cursor centered when jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")
