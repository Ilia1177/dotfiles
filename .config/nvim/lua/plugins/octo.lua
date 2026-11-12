return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  keys = {
    { "<leader>go", "<cmd>Octo<CR>", desc = "GitHub Octo" },
  },
  config = function()
    require("octo").setup({
      gh_cmd = vim.fn.exepath("gh") ~= "" and vim.fn.exepath("gh") or "gh",
    })
  end,
}
