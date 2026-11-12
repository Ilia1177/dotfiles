return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs", -- "buffers" ou "tabs"
      themable = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      separator_style = "thin",
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    },
  },
}
