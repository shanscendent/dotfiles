-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- force always cwd for find files/picker, etc
vim.g.root_spec = { "cwd" }

-- TODO: do I still need this?
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = "osc52"
vim.o.clipboard = "unnamedplus"

vim.g.ai_cmp = true
