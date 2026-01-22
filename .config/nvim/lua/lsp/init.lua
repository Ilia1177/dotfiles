local keymaps = require('config.keymaps')

local M = {}

function M.on_attach(client, bufnr)
  -- local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.lsp.completion.enable(true, client.id, bufnr)
  keymaps.setup_lsp(client, bufnr)
end

return M

