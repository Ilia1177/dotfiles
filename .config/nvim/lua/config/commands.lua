-- Commandes utilisateur liées au LSP

vim.api.nvim_create_user_command("LspRestart", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("Aucun client LSP attaché à ce buffer", vim.log.levels.WARN)
    return
  end

  for _, client in ipairs(clients) do
    vim.notify(("Redémarrage du LSP : %s"):format(client.name), vim.log.levels.INFO)
    client:stop()
  end

  -- Retrigger FileType plutôt que :edit
  vim.defer_fn(function()
    vim.cmd("doautocmd FileType")
  end, 100)
end, { desc = "Redémarrer les clients LSP du buffer courant" })

vim.api.nvim_create_user_command("LspLogClean", function()
  local log_path = vim.lsp.get_log_path()
  vim.fn.delete(log_path)
  vim.notify("Log LSP supprimé : " .. log_path, vim.log.levels.INFO)
end, { desc = "Supprimer le log LSP" })

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.edit(vim.lsp.get_log_path())
end, { desc = "Ouvrir le log LSP" })
