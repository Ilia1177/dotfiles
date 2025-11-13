return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})
  -- Auto-close Neovim if NvimTree is the last window open

  vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
      if #vim.api.nvim_list_wins() == 1 then
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "NvimTree" then
          vim.cmd("quit")
        end
      end
    end,
  })
    -- On utilise <leader>e pour ouvrir/fermer l'explorateur
    vim.keymap.set(
      "n",
      "<leader>e",
      "<cmd>NvimTreeFindFileToggle<CR>",
      { desc = "Ouverture/fermeture de l'explorateur de fichiers" }
    )
  end,
}
