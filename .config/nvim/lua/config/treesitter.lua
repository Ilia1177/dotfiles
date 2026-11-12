-- Treesitter : highlight, indentation et pliage.
-- nvim-treesitter (branche `main`) ne fournit plus de `configs.setup` :
-- l'installation des parsers est dans lua/plugins/treesitter.lua, et
-- l'activation des fonctionnalités se fait ici, par FileType.

local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

---@param lang string|nil
---@return boolean
local function parser_available(lang)
  if not lang then
    return false
  end
  return (pcall(vim.treesitter.language.add, lang))
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    local bufnr = args.buf
    local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
    if not parser_available(lang) then
      return
    end

    -- highlight
    pcall(vim.treesitter.start, bufnr, lang)

    -- indentation
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
