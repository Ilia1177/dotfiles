return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Ajouter ou ignorer un curseur au-dessus/en dessous du curseur principal
    set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
    set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
    set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
    set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

    -- Ajouter ou ignorer un curseur sur l'occurrence suivante/précédente
    set({ "n", "x" }, "m", function() mc.matchAddCursor(1) end, { desc = "Multicursor : occurrence suivante" })
    set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end, { desc = "Multicursor : ignorer l'occurrence" })
    set({ "n", "x" }, "M", function() mc.matchAddCursor(-1) end, { desc = "Multicursor : occurrence précédente" })
    set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end, { desc = "Multicursor : ignorer en arrière" })
    set({ "n", "x" }, "<leader>m", function() mc.matchAllAddCursors() end, { desc = "Multicursor : toutes les occurrences" })

    -- Curseurs via Ctrl + clic
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- Activer/désactiver les curseurs
    set({ "n", "x" }, "<c-q>", mc.toggleCursor)

    -- Mappings actifs uniquement quand il y a plusieurs curseurs
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Apparence des curseurs
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
