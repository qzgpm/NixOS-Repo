{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    # ── Global leaders ───────────────────────────────────────────────────────
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # ── Options ──────────────────────────────────────────────────────────────
    opts = {
      # UI
      number = true;
      relativenumber = true;
      cursorline = true;
      signcolumn = "yes";
      termguicolors = true;
      showmatch = true;
      wrap = false;
      scrolloff = 10;
      sidescrolloff = 8;
      splitbelow = true;
      splitright = true;
      synmaxcol = 240;
      showmode = false;
      pumheight = 10;

      # Timing
      updatetime = 200;
      timeoutlen = 300;

      # Editing
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;
      undofile = true;
      swapfile = false;
      autoread = true;
      autowrite = false;
      clipboard = "unnamedplus";

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # Completion
      completeopt = "menu,menuone,noinsert";
    };

    # ── Colorscheme ──────────────────────────────────────────────────────────
    colorscheme = "unokai";

    # ── Keymaps ──────────────────────────────────────────────────────────────
    keymaps = [
      # Visual — indenting / moving lines
      {
        mode = "v";
        key = "H";
        action = "<gv";
        options.silent = true;
        options.desc = "Indent left";
      }
      {
        mode = "v";
        key = "L";
        action = ">gv";
        options.silent = true;
        options.desc = "Indent right";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.silent = true;
        options.desc = "Move line down";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.silent = true;
        options.desc = "Move line up";
      }

      # Normal — misc
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>os";
        action = "<cmd>setlocal spell! spelllang=en_us<CR>";
        options.silent = true;
        options.desc = "Toggle spelling";
      }

      # FZF
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>FzfLua files<CR>";
        options.silent = true;
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>g";
        action = "<cmd>FzfLua live_grep<CR>";
        options.silent = true;
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>FzfLua buffers<CR>";
        options.silent = true;
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>c";
        action = "<cmd>FzfLua Commands<CR>";
        options.silent = true;
        options.desc = "Commands";
      }

      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.silent = true;
        options.desc = "Window left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.silent = true;
        options.desc = "Window down";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.silent = true;
        options.desc = "Window up";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.silent = true;
        options.desc = "Window right";
      }

      # Resize splits
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize +2<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize -2<CR>";
        options.silent = true;
      }

      # Centered jumps
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options.silent = true;
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options.silent = true;
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options.silent = true;
      }
    ];

    # ── Autocommands ─────────────────────────────────────────────────────────
    autoGroups = {
      DiagnosticColors = {clear = true;};
      YankHighlight = {clear = true;};
      AutoRead = {clear = true;};
      RestoreCursor = {clear = true;};
      FormatOnSave = {clear = true;};
      MarkdownSettings = {clear = true;};
    };

    autoCmd = [
      {
        group = "DiagnosticColors";
        event = ["ColorScheme"];
        pattern = "*";
        callback.__raw = ''
          function()
            local hl = vim.api.nvim_set_hl
            hl(0, "Normal",                   { bg = "none" })
            hl(0, "NormalNC",                 { bg = "none" })
            hl(0, "EndOfBuffer",              { bg = "none" })
            hl(0, "DiagnosticError",          { fg = "#ff6c6b" })
            hl(0, "DiagnosticWarn",           { fg = "#ECBE7B" })
            hl(0, "DiagnosticInfo",           { fg = "#51afef" })
            hl(0, "DiagnosticHint",           { fg = "#98be65" })
            hl(0, "DiagnosticUnderlineError", { undercurl = true })
            hl(0, "DiagnosticUnderlineWarn",  { undercurl = true })
            hl(0, "DiagnosticUnderlineInfo",  { undercurl = true })
            hl(0, "DiagnosticUnderlineHint",  { undercurl = true })
          end
        '';
      }

      # Highlight yanked text
      {
        group = "YankHighlight";
        event = ["TextYankPost"];
        pattern = "*";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
          end
        '';
      }

      # Auto-reload files changed outside Neovim
      {
        group = "AutoRead";
        event = ["FocusGained" "BufEnter" "CursorHold"];
        pattern = "*";
        callback.__raw = ''
          function()
            if vim.fn.getcmdwintype() == "" then
              vim.cmd("checktime")
            end
          end
        '';
      }

      # Restore cursor position
      {
        group = "RestoreCursor";
        event = ["BufReadPost"];
        pattern = "*";
        callback.__raw = ''
          function(args)
            local mark       = vim.api.nvim_buf_get_mark(args.buf, '"')
            local line_count = vim.api.nvim_buf_line_count(args.buf)
            if mark[1] > 0 and mark[1] <= line_count then
              vim.api.nvim_win_set_cursor(0, mark)
            end
          end
        '';
      }

      # Trim whitespace + LSP format on save
      {
        group = "FormatOnSave";
        event = ["BufWritePre"];
        pattern = "*";
        callback.__raw = ''
          function(args)
            if #vim.lsp.get_clients({ bufnr = args.buf }) == 0 then return end
            local pos = vim.fn.getpos(".")
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.setpos(".", pos)
            local ft = vim.bo[args.buf].filetype
            vim.lsp.buf.format({
              async      = false,
              timeout_ms = 2000,
              bufnr      = args.buf,
              filter     = function(client)
                if ft == "python" then return client.name == "ruff" end
                return true
              end,
            })
          end
        '';
      }

      # Markdown local settings
      {
        group = "MarkdownSettings";
        event = ["FileType"];
        pattern = ["markdown"];
        callback.__raw = ''
          function()
            vim.opt_local.conceallevel = 2
            vim.opt_local.wrap         = true
            vim.opt_local.linebreak    = true
          end
        '';
      }
    ];

    # ── Plugins ──────────────────────────────────────────────────────────────
    plugins = {
      # ── Icons ──────────────────────────────────────────────────────────────
      web-devicons.enable = true;

      # ── Lualine ────────────────────────────────────────────────────────────
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "auto";
            globalstatus = true;
            component_separators = "|";
            section_separators = {
              left = "";
              right = "";
            };
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = [
              {
                __unkeyed-1 = "filename";
                path = 1;
              }
            ];
            lualine_x = ["encoding" "fileformat" "filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
      };

      # ── Treesitter ─────────────────────────────────────────────────────────
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "c"
            "python"
            "nix"
            "lua"
            "bash"
            "markdown"
            "markdown_inline"
            "json"
          ];
          highlight.enable = true;
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              node_decremental = "<bs>";
            };
          };
        };
      };

      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
            };
          };
          move = {
            enable = true;
            set_jumps = true;
            goto_next_start = {
              "]f" = "@function.outer";
              "]c" = "@class.outer";
            };
            goto_previous_start = {
              "[f" = "@function.outer";
              "[c" = "@class.outer";
            };
          };
        };
      };

      # ── FZF ────────────────────────────────────────────────────────────────
      fzf-lua = {
        enable = true;
        settings.winopts.preview.enabled = true;
      };

      # ── Autopairs ──────────────────────────────────────────────────────────
      nvim-autopairs = {
        enable = true;
        settings = {};
      };

      # ── Completion ─────────────────────────────────────────────────────────
      cmp = {
        enable = true;
        settings = {
          window = {
            completion = {border = "rounded";};
            documentation = {border = "rounded";};
          };
          experimental.ghost_text = true;
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = ''
              cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select   = false,
              })
            '';
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_next_item()
                else fallback() end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_prev_item()
                else fallback() end
              end, { "i", "s" })
            '';
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}

            {
              name = "buffer";
              keyword_length = 4;
            }
          ];
          formatting.format.__raw = ''
            function(entry, item)
              item.menu = ({
                nvim_lsp = "󰅩 LSP",
                buffer   = "󰆼 BUF",
                path     = "󰉋 PATH",
              })[entry.source.name]
              return item
            end
          '';
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
    }; # end plugins

    # ── Extra Lua ─────────────────────────────────────────────────────────────
    extraConfigLua = ''

      -- Shared on_attach: keymaps + inlay hints
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr  = args.buf

          if client.name == "pyright" then
            client.server_capabilities.documentFormattingProvider = false
          end

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs,
              { buffer = bufnr, silent = true, desc = desc })
          end

          map("n", "gd",         vim.lsp.buf.definition,    "Go to definition")
          map("n", "gD",         vim.lsp.buf.declaration,   "Go to declaration")
          map("n", "gi",         vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gr",         vim.lsp.buf.references,    "References")
          map("n", "K",          vim.lsp.buf.hover,         "Hover docs")
          map("n", "<leader>ca", vim.lsp.buf.code_action,   "Code action")
          map("n", "<leader>rn", vim.lsp.buf.rename,        "Rename symbol")
          map("n", "<leader>dl", vim.diagnostic.open_float, "Diagnostic float")

          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
      })

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- ── Server configs ───────────────────────────────────────────────────────

      vim.lsp.config("pyright", {
        cmd      = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        settings = {
          python = {
            analysis = {
              typeCheckingMode       = "basic",
              autoSearchPaths        = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      vim.lsp.config("ruff", {
        cmd       = { "ruff", "server" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
      })

      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
        },
        filetypes    = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
      })

      vim.lsp.config("nixd", {
        cmd       = { "nixd" },
        filetypes = { "nix" },
        root_markers = { "flake.nix", "default.nix", "shell.nix", ".git" },
        settings = {
          nixd = {
            nixpkgs    = { expr = "import <nixpkgs> { }" },
            formatting = { command = { "alejandra" } },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        cmd       = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", "stylua.toml", ".git" },
        settings = {
          Lua = {
            runtime     = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })

      vim.lsp.config("marksman", {
        cmd       = { "marksman", "server" },
        filetypes = { "markdown", "markdown.mdx" },
        root_markers = { ".marksman.toml", ".git" },
      })

      vim.lsp.enable({
        "pyright",
        "ruff",
        "clangd",
        "nixd",
        "lua_ls",
        "marksman",
      })

      -- ── Diagnostics ─────────────────────────────────────────────────────────
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
          source    = true,
          focusable = false,
          style     = "minimal",
        },
      })

      do
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal",      { bg = "none" })
        hl(0, "NormalNC",    { bg = "none" })
        hl(0, "EndOfBuffer", { bg = "none" })
      end

      -- Enable faster Lua loader
      pcall(vim.loader.enable)
    '';

    # ── System packages needed by LSP servers ─────────────────────────────────
    extraPackages = with pkgs; [
      pyright
      ruff
      clang-tools # provides clangd
      nixd
      alejandra # nix formatter used by nixd
      lua-language-server
      marksman
    ];
  };
}
