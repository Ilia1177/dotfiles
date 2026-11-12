vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.lazy")

-- options, keymaps et autocmds généraux
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.treesitter")
require("config.commands")
require("config.terminal")
require("config.toggle-fold-comments")

-- LSP : comportement commun puis définition des serveurs
require("lsp")
require("lsp.servers")
