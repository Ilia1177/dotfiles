require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.terminal")
require("core.lazy")

require("lsp")          -- on_attach
require("lsp.clangd")  -- server configs
require("lsp.tsserver")
require("lsp.luaLs")
require("lsp.init")
require("lsp.commands")

