-- lua/lsp/tsserver.lua
local lsp = require("lsp")
local utils = require("lsp.utils")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },
  callback = function()
    -- Prevent duplicate clients
    if #vim.lsp.get_clients({ name = "tsserver", bufnr = 0 }) > 0 then
      return
    end

    vim.lsp.start({
      name = "tsserver",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = utils.get_root({
        "tsconfig.json",
        "package.json",
        "jsconfig.json",
        ".git",
      }) or vim.fn.getcwd(),
      on_attach = lsp.on_attach,
      capabilities = utils.default_capabilities(),
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })
  end,
})

