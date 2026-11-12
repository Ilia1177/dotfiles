return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      changedelete = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- navigation
      map("n", "]h", gs.next_hunk, "Hunk suivant")
      map("n", "[h", gs.prev_hunk, "Hunk précédent")

      -- actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage le hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset le hunk")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage la sélection")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset la sélection")

      map("n", "<leader>hS", gs.stage_buffer, "Stage le buffer")
      map("n", "<leader>hR", gs.reset_buffer, "Reset le buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "Annuler le stage")
      map("n", "<leader>hp", gs.preview_hunk, "Aperçu du hunk")
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame de la ligne")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Blame de ligne (toggle)")
      map("n", "<leader>hd", gs.diffthis, "Diff du buffer")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff contre HEAD~")

      -- text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Sélectionner le hunk")
    end,
  },
}
