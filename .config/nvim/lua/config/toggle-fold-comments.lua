-- Replie/déplie les blocs de commentaires multilignes (Treesitter).
-- <leader>fo

local M = {}

--- Itère sur les blocs de commentaires contigus du buffer
---@param bufnr integer
---@return fun(): integer|nil, integer|nil
local function iter_comment_blocks(bufnr)
  local empty = function() end

  local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok_parser or not parser then
    return empty
  end

  local ok_tree, trees = pcall(parser.parse, parser)
  local root = ok_tree and trees and trees[1] and trees[1]:root()
  if not root then
    return empty
  end

  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  -- certains grammaires utilisent `comment`, d'autres `line_comment`/`block_comment`
  local query
  for _, src in ipairs({ "(comment) @c", "[(line_comment) (block_comment)] @c" }) do
    local ok_query, parsed = pcall(vim.treesitter.query.parse, lang, src)
    if ok_query and parsed then
      query = parsed
      break
    end
  end
  if not query then
    return empty
  end

  -- regroupe les commentaires contigus
  local ranges = {}
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    local s, _, e = node:range()
    local last = ranges[#ranges]
    if last and s == last[2] + 1 then
      last[2] = math.max(last[2], e)
    else
      ranges[#ranges + 1] = { s, e }
    end
  end

  -- saute les blocs d'une seule ligne
  local i = 0
  return function()
    while ranges[i + 1] do
      i = i + 1
      local r = ranges[i]
      if r[2] > r[1] then
        return r[1] + 1, r[2] + 1
      end
    end
    return nil
  end
end

function M.toggle()
  local bufnr = vim.api.nvim_get_current_buf()
  local folded = not vim.b[bufnr].comments_folded

  vim.b[bufnr].foldmethod_backup = vim.wo.foldmethod
  vim.wo.foldmethod = "manual"
  vim.cmd("silent! normal! zE")

  if folded then
    local count = 0
    for s, e in iter_comment_blocks(bufnr) do
      vim.cmd(("%d,%dfold"):format(s, e))
      count = count + 1
    end
    vim.b[bufnr].comments_folded = true
    vim.notify(("%d bloc(s) de commentaires replié(s)"):format(count), vim.log.levels.INFO)
  else
    vim.b[bufnr].comments_folded = false
    vim.wo.foldmethod = vim.b[bufnr].foldmethod_backup or "expr"
    vim.notify("Commentaires dépliés", vim.log.levels.INFO)
  end
end

vim.keymap.set("n", "<leader>fo", M.toggle, { desc = "Replier/déplier les blocs de commentaires" })

return M
