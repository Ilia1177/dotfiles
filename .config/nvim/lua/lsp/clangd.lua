-- lua/lsp/clangd.lua

local lsp = require("lsp")
local utils = require("lsp.utils")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(args)
  vim.notify("FileType autocmd triggered for: " .. vim.bo[args.buf].filetype, vim.log.levels.INFO)

    if #vim.lsp.get_clients({ name = "clangd", bufnr = args.buf }) > 0 then
      return
    end

  root = utils.get_root({
	".clangd",
	".git",
	"Makefile",
	"compile_commands.json",
  }) or vim.fn.getcwd()

    vim.lsp.start({
      name = "clangd",
	  cmd = {
		  "clangd",
		  "--background-index",
		  "--clang-tidy",
		  "--all-scopes-completion",
		},
	  root_dir = root,
      on_attach = lsp.on_attach,
    })
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "c", "cpp" },
--   callback = function()
--     if #vim.lsp.get_clients({ name = "clangd", bufnr = 0 }) > 0 then
--       return
--     end
--
--     vim.lsp.start({
--       name = "clangd",
--       cmd = { "clangd", "--background-index" },
--       root_dir = utils.get_root({
--         ".clangd",
--         ".git",
--         "Makefile",
--         "compile_commands.json",
--       }),
--       on_attach = lsp.on_attach,
--       capabilities = utils.default_capabilities(),
--     })
--   end,
-- })
