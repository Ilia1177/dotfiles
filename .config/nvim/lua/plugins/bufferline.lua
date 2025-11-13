return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
		options = {
            mode = "tabs", -- "buffers" or set to "tabs" to only show tabpages instead
            themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
			hover = {
				enabled = true,
				delay = 200,
				reveal = {'close'}
			},
			separator_style = "thin",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
	},
  },
}
