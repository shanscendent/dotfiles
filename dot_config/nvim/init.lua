-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- for esp-idf, remember to install esp specific clang and add your .clangd files!
require("lspconfig").clangd.setup({})
vim.cmd(":Copilot disable")
