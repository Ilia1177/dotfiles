vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("core.lazy")
require("config.options")
require("config.keymaps")
require("config.keymaps").setup_general()
require("config.autocmds")
require("config.terminal")

require("lsp")          -- on_attach
require("lsp.clangd")  -- server configs
require("lsp.ts_ls")
require("lsp.luaLs")
require("lsp.init")
require("lsp.commands")
