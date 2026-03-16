-- ─────────────────────────────────────────────────────────────
-- Leader
-- ─────────────────────────────────────────────────────────────
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

pcall(vim.loader.enable)

-- ─────────────────────────────────────────────────────────────
-- Options
-- ─────────────────────────────────────────────────────────────
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
opt.updatetime  = 200
opt.timeoutlen  = 300

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

-- ─────────────────────────────────────────────────────────────
-- Lazy.nvim bootstrap
-- ─────────────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--depth=1",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ─────────────────────────────────────────────────────────────
-- Plugins
-- ─────────────────────────────────────────────────────────────
require("lazy").setup({

  -- ── Icons ────────────────────────────────────────────────
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ── Statusline ───────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme                = "auto",
        globalstatus         = true,
        component_separators = "|",
        section_separators   = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- ── FZF ──────────────────────────────────────────────────
  { "junegunn/fzf", build = "./install --bin" },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "Files", "Rg", "Buffers", "Commands" },
  },

  -- ── Autopairs ────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs     = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      autopairs.setup({})
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ── Completion ───────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        experimental = { ghost_text = true },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),

          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select   = false,
          }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            else fallback() end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            else fallback() end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources(
          { { name = "nvim_lsp" }, { name = "path" } },
          { { name = "buffer", keyword_length = 4 } }
        ),

        formatting = {
          format = function(entry, item)
            item.menu = ({
              nvim_lsp = "󰅩 LSP",
              buffer   = "󰆼 BUF",
              path     = "󰉋 PATH",
            })[entry.source.name]
            return item
          end,
        },
      })
    end,
  },

  -- ── LSP ──────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()

      -- ── Diagnostics ──────────────────────────────────────
      vim.diagnostic.config({
        virtual_text = {
          prefix  = "●",
          spacing = 2,
          source  = "if_many",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "󰌵",
          },
        },
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
        float = {
          border    = "rounded",
          source    = "always",
          focusable = false,
          style     = "minimal",
        },
      })

      -- ── on_attach ─────────────────────────────────────────
      local function on_attach(client, bufnr)
        if client.name == "pyright" then
          client.server_capabilities.documentFormattingProvider = false
        end

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs,
            { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "gd",         vim.lsp.buf.definition,    "Go to definition")
        map("n", "gD",         vim.lsp.buf.declaration,   "Go to declaration")
        map("n", "gi",         vim.lsp.buf.implementation,"Go to implementation")
        map("n", "gr",         vim.lsp.buf.references,    "References")
        map("n", "K",          vim.lsp.buf.hover,          "Hover docs")
        map("n", "<leader>ca", vim.lsp.buf.code_action,   "Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename,        "Rename symbol")
        map("n", "<leader>dl", vim.diagnostic.open_float, "Diagnostic float")
        map("n", "[d",         vim.diagnostic.goto_prev,  "Prev diagnostic")
        map("n", "]d",         vim.diagnostic.goto_next,  "Next diagnostic")

        -- Inlay hints (0.10+)
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- ── Root detection ────────────────────────────────────
      local function find_root(fname)
        local markers = {
          "flake.nix", "shell.nix",
          "compile_commands.json",
          "pyproject.toml", "setup.py",
          "Makefile", ".git",
        }
        local found = vim.fs.find(markers, { upward = true, path = fname })[1]
        return found and vim.fs.dirname(found) or vim.fn.getcwd()
      end

      -- ── Capabilities ──────────────────────────────────────
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── Generic LSP starter ───────────────────────────────
      local function setup_lsp(name, opts)
        vim.api.nvim_create_autocmd("FileType", {
          pattern  = opts.filetypes,
          callback = function(args)
            local bufnr = args.buf
            local fname  = vim.api.nvim_buf_get_name(bufnr)

            for _, c in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
              if c.name == name then return end
            end

            vim.lsp.start({
              name         = name,
              cmd          = opts.cmd,
              filetypes    = opts.filetypes,
              root_dir     = find_root(fname),
              on_attach    = on_attach,
              settings     = opts.settings or {},
              capabilities = capabilities,
              flags        = { debounce_text_changes = 150 },
            })
          end,
        })
      end

      setup_lsp("pyright", {
        filetypes = { "python" },
        cmd       = { "pyright-langserver", "--stdio" },
        settings  = {
          python = {
            analysis = {
              typeCheckingMode       = "basic",
              autoSearchPaths        = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      setup_lsp("ruff", {
        filetypes = { "python" },
        cmd       = { "ruff", "server" },
      })

      -- ── C / C++ ───────────────────────────────────────────
      setup_lsp("clangd", {
        filetypes = { "c", "cpp", "h", "hpp" },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
        },
      })

      -- ── Nix ───────────────────────────────────────────────
      setup_lsp("nixd", {
        filetypes = { "nix" },
        cmd       = { "nixd" },
        settings  = {
          nixd = {
            nixpkgs    = { expr = "import <nixpkgs> { }" },
            formatting = { command = { "alejandra" } },
          },
        },
      })

    end,
  },

}, {
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen",
        "netrwPlugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
})

-- ─────────────────────────────────────────────────────────────
-- Keymaps
-- ─────────────────────────────────────────────────────────────
local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs,
    vim.tbl_extend("force", { silent = true }, opts or {}))
end

-- Better indenting in visual mode
map("v", "H", "<gv", { desc = "Move line left" })
map("v", "L", ">gv", { desc = "Move line right" })
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

-- ─────────────────────────────────────────────────────────────
-- Autocommands
-- ─────────────────────────────────────────────────────────────
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Restore diagnostic highlight colors after colorscheme changes
autocmd("ColorScheme", {
  group    = augroup("DiagnosticColors", { clear = true }),
  callback = function()
    local hl = vim.api.nvim_set_hl
    hl(0, "DiagnosticError",          { fg = "#ff6c6b" })
    hl(0, "DiagnosticWarn",           { fg = "#ECBE7B" })
    hl(0, "DiagnosticInfo",           { fg = "#51afef" })
    hl(0, "DiagnosticHint",           { fg = "#98be65" })
    hl(0, "DiagnosticUnderlineError", { undercurl = true })
    hl(0, "DiagnosticUnderlineWarn",  { undercurl = true })
    hl(0, "DiagnosticUnderlineInfo",  { undercurl = true })
    hl(0, "DiagnosticUnderlineHint",  { undercurl = true })
  end,
})

-- Highlight yanked text briefly
autocmd("TextYankPost", {
  group    = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Auto-reload files changed outside Neovim
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group    = augroup("AutoRead", { clear = true }),
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Restore cursor position on file open
autocmd("BufReadPost", {
  group    = augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    local mark       = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- BufWritePre: trim whitespace + LSP format (uniform for all filetypes)
autocmd("BufWritePre", {
  group    = augroup("FormatOnSave", { clear = true }),
  pattern  = "*",
  callback = function(args)
    -- Trim trailing whitespace
    local pos = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", pos)

    vim.lsp.buf.format({
      async      = false,
      timeout_ms = 2000,
      bufnr      = args.buf,
    })
  end,
})

-- ─────────────────────────────────────────────────────────────
-- Colorscheme
-- ─────────────────────────────────────────────────────────────
vim.cmd.colorscheme("unokai")

local hl = vim.api.nvim_set_hl
hl(0, "Normal",      { bg = "none" })
hl(0, "NormalNC",    { bg = "none" })
hl(0, "EndOfBuffer", { bg = "none" })
