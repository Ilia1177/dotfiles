-- return {
--     "rmagatti/goto-preview",
--     dependencies = { "rmagatti/logger.nvim" },
--     event = "BufEnter",
--     config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
-- }
return
{
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = function()
    require('goto-preview').setup({
      default_mappings = true, -- optional
      post_open_hook = function(buf, win)
        -- Example: automatically resize preview window
        vim.api.nvim_win_set_width(win, 100)
      end,
      references = { telescope = true },
      focus_on_open = true,
      width = 120,
      height = 20,
    })
  end,
}
