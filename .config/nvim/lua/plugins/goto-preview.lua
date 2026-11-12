return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  keys = {
    { "gpd", function() require("goto-preview").goto_preview_definition() end, desc = "Aperçu de la définition" },
    { "gpD", function() require("goto-preview").goto_preview_declaration() end, desc = "Aperçu de la déclaration" },
    { "gpi", function() require("goto-preview").goto_preview_implementation() end, desc = "Aperçu de l'implémentation" },
    { "gpr", function() require("goto-preview").goto_preview_references() end, desc = "Aperçu des références" },
    { "gpt", function() require("goto-preview").goto_preview_type_definition() end, desc = "Aperçu du type" },
    { "gP", function() require("goto-preview").close_all_win() end, desc = "Fermer les aperçus" },
  },
  opts = {
    default_mappings = false,
    focus_on_open = true,
    width = 120,
    height = 20,
    references = { telescope = true },
    post_open_hook = function(_, win)
      vim.api.nvim_win_set_width(win, 100)
    end,
  },
}
