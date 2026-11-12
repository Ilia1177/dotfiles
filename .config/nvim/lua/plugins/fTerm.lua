return {
  "numToStr/FTerm.nvim",
  keys = {
    { "<leader>ft", "<cmd>lua require('FTerm').toggle()<CR>", desc = "Afficher/masquer le terminal (FTerm)" },
  },
  config = function()
    require("FTerm").setup({
      -- cd dans le cwd courant au lancement du shell
      cmd = function()
        local cwd = vim.fn.getcwd()
        local shell = os.getenv("SHELL") or "zsh"
        return string.format("cd %s && exec %s", vim.fn.shellescape(cwd), shell)
      end,
      border = "double",
      dimensions = { height = 0.9, width = 0.9 },
    })
  end,
}
