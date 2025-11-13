return {
  {
    "hardyrafael17/norminette42.nvim",
    config = function()
      require("norminette").setup({
		runOnSave = true,
		maxErrorsToShow = 5,
		active = true,
        files = { "*.c", "*.h" }, -- optional
      })
    end,
  }
}
