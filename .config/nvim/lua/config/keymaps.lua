local M = {}
-- On définit notre touche leader sur espace
vim.g.mapleader = " "
local keymap = vim.keymap.set

function M.setup_general()
	keymap("i", ";;", "<ESC>", { desc = "Sortir du mode insertion avec ;;" })
	keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Effacer le surlignage de la recherche" })
	keymap("v", "<M-k>", ":m .-2<CR>==", { desc = "Déplace le texte sélectionné vers le haut en mode visuel" })
	keymap("v", "<M-j>", ":m .+1<CR>==", { desc = "Déplace le texte sélectionné vers le bas en mode visuel" })
	keymap("x", "<M-k>", ":move '<-2<CR>gv-gv", { desc = "Déplace le texte sélectionné vers le haut en mode visuel bloc" })
	keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", { desc = "Déplace le texte sélectionné vers le bas en mode visuel bloc" })
	keymap("n", "<C-h>", "<C-w>h", { desc = "Déplace le curseur dans la fenêtre de gauche" })
	keymap("n", "<C-j>", "<C-w>j", { desc = "Déplace le curseur dans la fenêtre du bas" })
	keymap("n", "<C-k>", "<C-w>k", { desc = "Déplace le curseur dans la fenêtre du haut" })
	keymap("n", "<C-l>", "<C-w>l", { desc = "Déplace le curseur dans la fenêtre droite" })
	keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Recherche de chaînes de caractères dans les noms de fichiers" })
	keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Recherche de chaînes de caractères dans le contenu des fichiers" })
	keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Recherche de chaînes de caractères dans les noms de buffers" })
	keymap("n", "<leader>fx", "<cmd>Telescope grep_string<cr>", { desc = "Recherche de la chaîne de caractères sous le curseur" })
	-- keymap("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
		-- goto-preview keymaps
	keymap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", 
		{ noremap = true, desc = "Goto preview implementation (.cpp/.c)" })

	keymap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", 
		{ noremap = true, desc = "Goto preview definition (.hpp/.h)" })

	keymap("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", 
		{ noremap = true, desc = "Goto preview declaration (.hpp/.h)" })

	keymap("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", 
		{ noremap = true, desc = "Goto preview references (.hpp/.h)" })

	keymap("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", 
		{ noremap = true, desc = "Goto preview type definition (.hpp/.h)" })

	keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", 
		{ noremap = true, desc = "Close all goto-preview windows" })

	keymap("n", "gh", "<cmd>ClangdSwitchSourceHeader<CR>", 
		{ noremap = true, desc = "Switch between header and source" })

		-- Maximize current window height
	keymap("n", "<leader>wm", "<C-w>_", { desc = "Maximize window height" })
	keymap("n", "<leader>we", "<C-w>=", { desc = "Equalize window sizes" })
	keymap("n", "<leader>wo", ":only<CR>", { desc = "Close all other windows" })
end

function M.setup_lsp(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  keymap('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap('n', 'gd', vim.lsp.buf.definition, opts)
  keymap('n', 'K', vim.lsp.buf.hover, opts)
  keymap('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap('n', 'gr', vim.lsp.buf.references, opts)
  keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap('n', '<leader>f', function() 
	vim.lsp.buf.format { async = true }
  end, opts)
end

return M

