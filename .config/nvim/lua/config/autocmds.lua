-- -- set tabulation = 2 spaces for htmls and others files...
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "yaml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
--
-- -- syntax for .tpp files (same as .cpp)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.tpp",
    callback = function()
        vim.bo.filetype = "cpp"
    end,
})
--
-- vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
--   pattern = {"*.cpp", "*.c", "*.h", "*.hpp"},
--   callback = function()
--     -- recompute folds
--     vim.cmd("normal! zx")  -- recalc folds
--     vim.opt_local.foldlevel = 0  -- start folded
--   end,
-- })
-- vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
--   pattern = {"*.cpp", "*.c", "*.h", "*.hpp"},
--   callback = function()
--     -- wait until the next event loop tick to ensure Treesitter is ready
--     vim.defer_fn(function()
--       vim.cmd("normal! zx")      -- recalc folds
--       vim.opt_local.foldlevel = 0 -- start folded
--     end, 0)
--   end,
-- })

-- Optional: Force fold recalculation for C/C++ files
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = {"*.cpp", "*.c", "*.h", "*.hpp"},
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Ensure Treesitter parser is available
    local has_parser = pcall(vim.treesitter.get_parser, bufnr, "cpp")
    if has_parser then
      -- Small delay to ensure Treesitter is fully loaded
      vim.defer_fn(function()
        -- Only recalculate if the buffer is still valid
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.cmd("normal! zx")  -- Recalculate folds
        end
      end, 100)
    end
  end,
})
