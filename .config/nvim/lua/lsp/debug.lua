-- Save this as a temporary file and source it with :luafile %
vim.lsp.config("ts_ls_test", {
  cmd = { "/opt/homebrew/bin/typescript-language-server", "--stdio" },
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_markers = { "tsconfig.json", "package.json" },
  on_attach = function(client, bufnr)
    print("✅ SUCCESS: Attached to buffer " .. bufnr)
  end,
})

vim.lsp.enable("ts_ls_test")

-- Force start for current buffer
vim.lsp.start("ts_ls_test")
