
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvim_tree = require("nvim-tree")
    nvim_tree.setup({
	  git = {
		enable = true,
		ignore = false,
	  },
	  sync_root_with_cwd = true,
      respect_buf_cwd = true,
	  update_focused_file = {
        enable = true,
        update_root = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = false,
      },
      view = {
        side = "left",
        width = 30,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Override '.' to change root to folder under cursor
        api.config.mappings.default_on_attach(bufnr) -- load default mappings first
        vim.keymap.set("n", ".", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.nodes ~= nil then
            api.tree.change_root(node.absolute_path)
          end
        end, opts("Set folder as tree root"))
      end,
    })

	vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})

    -- Toggle explorer with <leader>e
    vim.keymap.set(
      "n",
      "<leader>e",
      "<cmd>NvimTreeFindFileToggle<CR>",
      { desc = "Ouverture/fermeture de l'explorateur de fichiers" }
    )
  end,
}
