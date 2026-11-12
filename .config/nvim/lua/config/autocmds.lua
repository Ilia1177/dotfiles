local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- Indentation à 2 espaces pour le web et les fichiers de config
local two_space_filetypes = {
  "html",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = two_space_filetypes,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Les .tpp sont du C++
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*.tpp",
  callback = function()
    vim.bo.filetype = "cpp"
  end,
})

-- Recalcule les folds une fois le parser Treesitter chargé (C/C++)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = augroup,
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function(args)
    if not vim.api.nvim_buf_is_valid(args.buf) then
      return
    end
    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_call(args.buf, function()
          pcall(vim.cmd, "silent! normal! zx")
        end)
      end
    end, 50)
  end,
})
