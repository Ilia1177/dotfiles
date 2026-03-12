-- ~/.config/nvim/lua/plugins/git.lua or similar
return {
  -- For local diff and merge management
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git Diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git File History" },
    },
    config = true,
  },
  -- For GitHub PR and issue management
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- Or fzf-lua
      "nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
      { "<leader>go", "<cmd>Octo<CR>", desc = "GitHub Octo" },
    },
    config = function()
	  require("octo").setup({
		  gh_cmd = "/opt/homebrew/bin/gh",  -- Use the path from 'which gh'
		})
    end,
  },
}
