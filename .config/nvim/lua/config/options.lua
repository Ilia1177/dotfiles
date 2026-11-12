local opt = vim.opt -- raccourci pour un peu plus de concision

-- numéros de ligne
opt.relativenumber = true -- numéros relatifs à la position du curseur
opt.number = true -- numéro absolu sur la ligne active

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true -- conserve l'indentation de la ligne précédente

-- recherche
opt.ignorecase = true -- recherche insensible à la casse…
opt.smartcase = true -- …sauf si la recherche contient une majuscule
opt.hlsearch = true -- surligne toutes les occurrences

-- ligne du curseur
opt.cursorline = true

-- apparence
opt.termguicolors = true -- nécessaire pour les thèmes modernes
opt.background = "dark"
opt.signcolumn = "yes" -- évite de décaler le texte quand des signes apparaissent
opt.colorcolumn = "80"

-- retour
opt.backspace = "indent,eol,start"

-- presse-papier
opt.clipboard = "unnamedplus"

-- fenêtres
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- divers
opt.swapfile = false
opt.undofile = true
opt.confirm = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.updatetime = 250 -- diagnostics, gitsigns, document highlight plus réactifs
opt.timeoutlen = 400
opt.iskeyword:append("-") -- les mots contenant un - restent un seul mot

-- caractères spéciaux
opt.list = true
opt.listchars:append({ nbsp = "␣", trail = "•", precedes = "«", extends = "»", tab = "> " })

-- retour à la ligne
opt.wrap = true
opt.linebreak = true -- coupe aux frontières de mots
opt.breakindent = true -- aligne visuellement les lignes coupées

-- pliage basé sur Treesitter (voir aussi lua/config/treesitter.lua)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
