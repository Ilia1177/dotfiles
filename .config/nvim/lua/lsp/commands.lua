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
  -- vim.defer_fn(function()
  --   vim.cmd('edit')
  --   print("LSP restarted")
  -- end, 100)

  -- Retrigger FileType instead of :edit
    vim.defer_fn(function()
    vim.cmd('doautocmd FileType')
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

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = {"*.cpp", "*.c", "*.h", "*.hpp"},
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Check if parser exists before trying to use it
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "cpp")
    if ok and parser then
      -- Schedule recalculation after Treesitter is ready
      vim.defer_fn(function()
        vim.cmd("normal! zx")       -- recalc folds
        vim.opt_local.foldlevel = 99 -- start unfolded
      end, 50)
    end
  end,
})
