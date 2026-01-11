-- lua/lsp/utils.lua
local M = {}

function M.get_root(markers)
  return vim.fs.dirname(vim.fs.find(markers, { upward = true })[1])
    or vim.fn.getcwd()
end

function M.default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

return M
