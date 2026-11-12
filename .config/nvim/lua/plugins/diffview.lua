return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Historique du fichier" },
  },
  config = true,
}
