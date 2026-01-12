-- vim.lsp.config('lua_ls', {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
--   root_dir = utils.get_root(root_markers) or vim.fn.getcwd(),
--
--   single_file_support = true,  -- ⭐ THIS FIXES IT
--   on_attach = require("lsp").on_attach,
--   -- ...
--   capabilities = require("lsp.utils").default_capabilities(),
--
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         globals = { 'vim' },
-- 		disable = { "undefined-field" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })
--
-- vim.lsp.enable('lua_ls')

-- local root_markers = { '.luarc.json', '.luarc.jsonc', '.git' }
--
-- vim.lsp.config('lua_ls', {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_markers = root_markers,
--   root_dir = utils.get_root(root_markers) or vim.fn.getcwd(),
--   single_file_support = true,
--   on_attach = require("lsp").on_attach,
--   capabilities = require("lsp.utils").default_capabilities(),
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         globals = { 'vim' },
--         disable = { "undefined-field" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })
-- vim.lsp.enable('lua_ls')
local utils = require("lsp.utils")

local root_markers = { '.luarc.json', '.luarc.jsonc', '.git' }

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = root_markers,
  root_dir = utils.get_root(root_markers) or vim.fn.getcwd(),
  single_file_support = true,
  on_attach = require("lsp").on_attach,
  capabilities = utils.default_capabilities(),
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
        disable = { "undefined-field" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable('lua_ls')
