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

-- Trim whitespace + LSP format on save
autocmd("BufWritePre", {
  group   = augroup("FormatOnSave", { clear = true }),
  pattern = "*",
  callback = function(args)
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
        if ft == "python" then
          return client.name == "ruff"
        end
        return true
      end,
    })
  end,
})

-- Markdown local settings
autocmd("FileType", {
  group   = augroup("MarkdownSettings", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.wrap         = true
    vim.opt_local.linebreak    = true
  end,
})
