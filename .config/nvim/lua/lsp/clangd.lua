-- local lsp = require("lsp")
-- local utils = require("lsp.utils")
--
-- local binary = "/usr/bin/clangd"
--
-- vim.lsp.config("clangd", {
--   cmd = { binary, "--background-index", "--clang-tidy", "--pch-storage=memory"},
--   filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
--   root_markers = { ".git", "compile_commands.json", "compile_flags.txt", "CMakeLists.txt", ".clangd" },
--   on_attach = function(client, bufnr)
--     lsp.on_attach(client, bufnr)
--   end,
--   capabilities = utils.default_capabilities(),
-- })
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         update_in_insert = true,
-- 		 	debounce_text_changes = 100, -- lower = faster (default is 150ms)
--     }
-- )
-- vim.lsp.enable("clangd")
-- nvim/lua/lsp/clangd.lua  ← fix the extension!
local lsp = require("lsp")
local utils = require("lsp.utils")
local binary = "/usr/bin/clangd"

vim.lsp.config("clangd", {
  cmd = {
    binary,
    "--background-index",
    "--clang-tidy",
    "--pch-storage=memory",
    "--completion-style=detailed",  -- better completions
    "--header-insertion=iwyu",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".git",
    "compile_commands.json",
    "compile_flags.txt",
    "CMakeLists.txt",
    ".clangd",
  },
  single_file_support = true,   -- ← fixes detachment on buffers without root
  autostart = true,
  on_attach = function(client, bufnr)
    lsp.on_attach(client, bufnr)
  end,
  capabilities = utils.default_capabilities(),
})

-- Correct way to configure diagnostics in Neovim 0.10+
vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = true,
  signs = true,
  underline = true,
})

vim.lsp.enable("clangd")
