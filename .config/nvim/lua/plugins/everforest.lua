return {
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    -- chargement du thème
    vim.g.everforest_background = "medium" -- options: 'soft', 'medium', 'hard'
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_transparent_background = 0
    vim.cmd([[colorscheme everforest]])
  end,
}
