-- Comportement LSP commun à tous les serveurs
-- (les définitions de serveurs sont dans lua/lsp/servers.lua)

-- Capacités : cmp-nvim-lsp les enrichit si disponible
local capabilities
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_lsp.default_capabilities()
else
  capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

vim.lsp.config("*", { capabilities = capabilities })

vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if not client then
      return
    end

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("gD", vim.lsp.buf.declaration, "Déclaration")
    map("gd", vim.lsp.buf.definition, "Définition")
    map("K", vim.lsp.buf.hover, "Documentation")
    map("gi", vim.lsp.buf.implementation, "Implémentation")
    map("gr", vim.lsp.buf.references, "Références")
    map("<leader>rn", vim.lsp.buf.rename, "Renommer")
    map("<leader>ca", vim.lsp.buf.code_action, "Action de code")

    if client.name == "clangd" then
      map("gh", "<cmd>ClangdSwitchSourceHeader<CR>", "Basculer entre en-tête et source")
    end

    -- surlignage des références sous le curseur
    if client:supports_method("textDocument/documentHighlight") then
      local group = vim.api.nvim_create_augroup("UserLspHighlight" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
