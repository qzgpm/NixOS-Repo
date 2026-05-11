return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()

    -- ── Diagnostics ──────────────────────────────────────────
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

    -- ── on_attach ────────────────────────────────────────────
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

      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    -- ── Root detection ────────────────────────────────────────
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

    -- ── Capabilities ──────────────────────────────────────────
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- ── Generic LSP starter ───────────────────────────────────
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

    -- ── Servers ───────────────────────────────────────────────
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
}
