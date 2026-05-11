return {
  -- ── Autopairs ──────────────────────────────────────────────
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

  -- ── nvim-cmp ───────────────────────────────────────────────
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
}
