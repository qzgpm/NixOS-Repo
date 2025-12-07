-- ────────────────────────────────
-- 🚀 Lazy.nvim bootstrap
-- ────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ────────────────────────────────
-- Lazy.nvim plugins
-- ────────────────────────────────
require("lazy").setup({

  -- FZF
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto", globalstatus = true }
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- LSPCONFIG
  {
    "neovim/nvim-lspconfig",
    config = function()

      -- ───── Diagnostics ─────
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- ───── Keymaps on LSP attach ─────
      local function on_attach(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)

        if type(vim.lsp.inlay_hint) == "function" then
          vim.lsp.inlay_hint(bufnr, true)
        end
      end

      -- ───── Root dir helper ─────
      local function find_root(fname)
        local roots = {
          "pyproject.toml", "setup.py", ".git", "compile_commands.json", "Makefile"
        }
        local root = vim.fs.find(roots, { upward = true, path = fname })[1]
        return root and vim.fs.dirname(root) or vim.fn.getcwd()
      end

      -- ───── LSP wrapper: Add ANY LSP easily ─────
      local function setup_lsp(name, opts)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.filetypes,
          callback = function(args)
            local bufnr = args.buf
            local fname = vim.api.nvim_buf_get_name(bufnr)

            -- Avoid duplicate clients
            for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
              if client.name == name then return end
            end

            vim.lsp.start({
              name = name,
              cmd = opts.cmd,
              filetypes = opts.filetypes,
              root_dir = find_root(fname),
              on_attach = on_attach,
              settings = opts.settings or {},
            })
          end,
        })
      end

      -- ────────────────────────────────
      -- LSP Servers
      -- ────────────────────────────────

      -- Python (Pyright)
      setup_lsp("pyright", {
        filetypes = { "python" },
        cmd = { "pyright-langserver", "--stdio" },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- C / C++
      setup_lsp("clangd", {
        filetypes = { "c", "cpp", "h", "hpp" },
        cmd = { "clangd" },
      })

    end,
  },

})

-- ────────────────────────────────
-- General options
-- ────────────────────────────────
vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.autoread = true
vim.o.autowrite = false
vim.opt.clipboard:append("unnamedplus")

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- Theme
vim.cmd.colorscheme("vim")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Visual
vim.o.termguicolors = true
vim.o.showmatch = true

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.g.mapleader = " "

-- Toggle spelling
vim.keymap.set("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>")

-- FZF
vim.keymap.set("n", "<leader>f", ":Files<CR>")
vim.keymap.set("n", "<leader>g", ":Rg<CR>")
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
vim.keymap.set("n", "<leader>c", ":Commands<CR>")

-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save)
  end,
})
