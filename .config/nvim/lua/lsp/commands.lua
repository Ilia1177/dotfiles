-- Restart LSP command
vim.api.nvim_create_user_command('LspRestart', function()
  local clients = vim.lsp.get_clients({bufnr=0})
  if #clients == 0 then
    print("No LSP clients attached to this buffer")
    return
  end
  
  for _, client in ipairs(clients) do
    print(string.format("Restarting LSP: %s", client.name))
    vim.lsp.stop_client(client.id)
  end
  
  -- Wait a moment then reload the buffer to retrigger LSP
  vim.defer_fn(function()
    vim.cmd('edit')
    print("LSP restarted")
  end, 100)
end, {})
-- Clean LSP log command
vim.api.nvim_create_user_command('LspLogClean', function()
  local log_path = vim.lsp.get_log_path()
  vim.fn.delete(log_path)
  print("LSP log cleaned: " .. log_path)
end, {})

-- View and clean LSP logs
vim.api.nvim_create_user_command('LspLog', function()
  local log_path = vim.lsp.get_log_path()
  vim.cmd('edit ' .. log_path)
end, {})
