-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.lsp.enable({ "jdtls", "nil_ls", "tofu_ls" })
