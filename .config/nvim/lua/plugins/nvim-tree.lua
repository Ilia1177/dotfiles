return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false, -- chargé tôt pour intercepter l'ouverture d'un dossier
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
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

        api.config.mappings.default_on_attach(bufnr)

        -- '.' : définir le dossier sous le curseur comme racine
        vim.keymap.set("n", ".", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.nodes ~= nil then
            api.tree.change_root(node.absolute_path)
          end
        end, opts("Définir ce dossier comme racine"))
      end,
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Afficher/masquer l'explorateur" })

    -- ne pas quitter Neovim avec seulement l'explorateur ouvert
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            invalid_win[#invalid_win + 1] = w
          end
        end
        if #invalid_win == #wins - 1 then
          for _, w in ipairs(invalid_win) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
