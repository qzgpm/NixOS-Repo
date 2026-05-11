return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent    = { enable = true },
        incremental_selection = {
          enable  = true,
          keymaps = {
            init_selection   = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    build = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable              = true,
            set_jumps           = true,
            goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          },
        },
      })
    end,
  },
}
