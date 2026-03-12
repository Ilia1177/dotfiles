local lsp = require("lsp")
local utils = require("lsp.utils")

local binary = "/opt/homebrew/bin/typescript-language-server"

vim.lsp.config("ts_ls", {
  cmd = { binary, "--stdio" },
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_markers = {".git", "tsconfig.json", "package.json", "jsconfig.json"},
  on_attach = function(client, bufnr)
    lsp.on_attach(client, bufnr)
  end,
  on_exit = function(code, signal, client_id) end,
  capabilities = utils.default_capabilities(),
})

vim.lsp.enable("ts_ls")
