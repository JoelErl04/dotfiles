local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Flash yanked region so you can see what was copied
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yanked text",
})

-- Strip trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)  -- save cursor position
    vim.cmd([[%s/\s\+$//e]])                     -- silent substitute
    vim.api.nvim_win_set_cursor(0, pos)          -- restore cursor position
  end,
  desc = "Remove trailing whitespace on save",
})

-- 2-space indent for web and config filetypes
autocmd("FileType", {
  group = augroup("filetype_indent", { clear = true }),
  pattern = { "javascript", "typescript", "html", "css", "json", "yaml", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "2-space indent for web and config files",
})

-- Restore cursor to last known position when reopening a file
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = "Restore cursor to last position",
})
