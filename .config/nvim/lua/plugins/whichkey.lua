return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>c", group = "code" },
      { "<leader>d", group = "diagnostics / buffers" },
      { "<leader>f", group = "fichiers / recherche" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunks git" },
      { "<leader>n", group = "documentation" },
      { "<leader>s", group = "recherche / multicursor" },
      { "<leader>t", group = "terminal" },
      { "<leader>w", group = "fenêtres" },
      { "<leader>x", group = "diagnostics" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Keymaps du buffer (which-key)",
    },
  },
}
