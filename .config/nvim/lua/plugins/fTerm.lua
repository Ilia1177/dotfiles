--return {
--  "numToStr/FTerm.nvim",
--  keys = {
--    {
--      "<leader>ft",
--      "<cmd>lua require('FTerm').toggle()<CR>",
--      desc = "Toggle Terminal"
--    }
--  },
--  config = function()
--    require("FTerm").setup({
--      	cmd = os.getenv("SHELL") or zsh,
--		cwd = function()
--			return vim.fn.getcwd()
--    	end
--		border = "double",
--		dimensions = {
--		height = 0.9,
--		width = 0.9,
--      },
--    })
--  end,
-- }
return {
  "numToStr/FTerm.nvim",
  keys = {
    {
      "<leader>ft",
      "<cmd>lua require('FTerm').toggle()<CR>",
      desc = "Toggle Terminal"
    }
  },
  config = function()
    local FTerm = require("FTerm")

    FTerm.setup({
      -- Explicitly cd into the current working directory when launching shell
      cmd = function()
        local cwd = vim.fn.getcwd()
        local shell = os.getenv("SHELL") or "zsh"
        return string.format("cd %s && exec %s", cwd, shell)
      end,

      border = "double",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    })
  end,
}
