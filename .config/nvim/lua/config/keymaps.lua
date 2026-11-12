-- Keymaps généraux.
-- Les keymaps propres aux plugins vivent dans leur spec (lua/plugins/*.lua),
-- ceux du LSP dans lua/lsp/init.lua (autocmd LspAttach).
local keymap = vim.keymap.set

-- édition
keymap("i", ";;", "<Esc>", { desc = "Sortir du mode insertion avec ;;" })
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Effacer le surlignage de la recherche" })

-- déplacer du texte en mode visuel
keymap("v", "<M-k>", ":m .-2<CR>==", { desc = "Déplacer le texte sélectionné vers le haut" })
keymap("v", "<M-j>", ":m .+1<CR>==", { desc = "Déplacer le texte sélectionné vers le bas" })
keymap("x", "<M-k>", ":move '<-2<CR>gv-gv", { desc = "Déplacer le texte sélectionné vers le haut (bloc)" })
keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", { desc = "Déplacer le texte sélectionné vers le bas (bloc)" })

-- navigation entre fenêtres
keymap("n", "<C-h>", "<C-w>h", { desc = "Fenêtre de gauche" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Fenêtre du bas" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Fenêtre du haut" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Fenêtre de droite" })

-- gestion des fenêtres
keymap("n", "<leader>wm", "<C-w>_", { desc = "Maximiser la hauteur de la fenêtre" })
keymap("n", "<leader>we", "<C-w>=", { desc = "Égaliser la taille des fenêtres" })
keymap("n", "<leader>wo", ":only<CR>", { desc = "Fermer les autres fenêtres" })
