return {
  "echasnovski/mini.bufremove",
  version = "*",
  config = function()
    vim.keymap.set("n", "<leader>db", function()
      require("mini.bufremove").delete(0, false)
    end, { desc = "Delete buffer safely" })
  end
}
