-- ────────────────────────────────
-- Leader
-- ────────────────────────────────
vim.g.mapleader = " "

-- Enable faster Lua loader
pcall(vim.loader.enable)

-- Faster startup
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240

-- ────────────────────────────────
-- 🚀 Lazy.nvim bootstrap
-- ────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--depth=1",
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
  {
    "junegunn/fzf",
    build = "./install --bin",
  },

  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "Files", "Rg", "Buffers", "Commands" },
  },

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
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({})

      local cmp_autopairs =
        require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done",
        cmp_autopairs.on_confirm_done())
    end,
  },

  -- Completion
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
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      experimental = {
        ghost_text = true,
      },

      mapping = cmp.mapping.preset.insert({

        ["<C-Space>"] = cmp.mapping.complete(),

        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer", keyword_length = 4 },
      }),

      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "󰅩 LSP",
            buffer = "󰆼 BUF",
            path = "󰉋 PATH",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
    end,
  },

  -- LSPCONFIG
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()

      -- Diagnostics
      vim.diagnostic.config({

        -- inline messages
        virtual_text = {
          prefix = "●",
          spacing = 2,
          source = "if_many",
        },

        -- gutter icons
        signs = true,

        underline = true,
        update_in_insert = false,
        severity_sort = true,

        float = {
          border = "rounded",
          source = "always",
          focusable = false,
          style = "minimal",
        },
      })

      -- On attach
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

      -- Root detection
      local function find_root(fname)
        local roots = {
          "pyproject.toml", "setup.py", ".git",
          "compile_commands.json", "Makefile"
        }
        local root = vim.fs.find(roots, { upward = true, path = fname })[1]
        return root and vim.fs.dirname(root) or vim.fn.getcwd()
      end

      -- Capabilities for completion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP wrapper
      local function setup_lsp(name, opts)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = opts.filetypes,
          callback = function(args)
            local bufnr = args.buf
            local fname = vim.api.nvim_buf_get_name(bufnr)

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
              capabilities = capabilities,
              flags = {
                debounce_text_changes = 150,
              },
            })
          end,
        })
      end

      -- Python
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
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
        },
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
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.splitbelow = true
vim.o.splitright = true

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Visual
vim.o.termguicolors = true
vim.o.showmatch = true

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Toggle spelling
vim.keymap.set("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>")

-- FZF mappings
vim.keymap.set("n", "<leader>f", ":Files<CR>")
vim.keymap.set("n", "<leader>g", ":Rg<CR>")
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
vim.keymap.set("n", "<leader>c", ":Commands<CR>")

-- Window navigation without <C-w>
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to lower window" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to upper window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right window" })

-- Resize splits using Ctrl + Arrow keys
vim.keymap.set('n', '<C-Up>',    ':resize +2<CR>',          { silent = true })
vim.keymap.set('n', '<C-Down>',  ':resize -2<CR>',          { silent = true })
vim.keymap.set('n', '<C-Left>',  ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', { silent = true })

-- Restore diagnostic highlight colors
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd("highlight DiagnosticError guifg=#ff6c6b")
    vim.cmd("highlight DiagnosticWarn  guifg=#ECBE7B")
    vim.cmd("highlight DiagnosticInfo  guifg=#51afef")
    vim.cmd("highlight DiagnosticHint  guifg=#98be65")

    vim.cmd("highlight DiagnosticUnderlineError gui=undercurl")
    vim.cmd("highlight DiagnosticUnderlineWarn  gui=undercurl")
    vim.cmd("highlight DiagnosticUnderlineInfo  gui=undercurl")
    vim.cmd("highlight DiagnosticUnderlineHint  gui=undercurl")
  end,
})

-- Theme
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save)
  end,
})
