return {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  cmd = "Neogen",
  keys = {
    { "<leader>ng", function() require("neogen").generate() end, desc = "Générer la documentation" },
    { "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Documenter une fonction" },
    { "<leader>nc", function() require("neogen").generate({ type = "class" }) end, desc = "Documenter une classe" },
    {
      "<leader>nC",
      function()
        local line = vim.api.nvim_get_current_line()
        if line:match("^[%s]*[%w_:]+::[%w_:]+%(.*%).*[:{].*$") then
          -- constructeur : neogen ne le gère pas, fallback manuel
          vim.api.nvim_put({
            "/**",
            " * @brief Construct a new object",
            " * ",
            " * @param port ",
            " * @param psswd ",
            " */",
          }, "l", true, true)
          vim.cmd("normal! 6k2w")
        else
          require("neogen").generate({ type = "func" })
        end
      end,
      desc = "Documenter un constructeur",
    },
  },
  opts = {
    enabled = true,
    snippet_engine = "luasnip",
    languages = {
      cpp = {
        template = {
          annotation_convention = "doxygen",
        },
      },
      c = {
        template = {
          annotation_convention = "doxygen",
        },
      },
    },
  },
}
