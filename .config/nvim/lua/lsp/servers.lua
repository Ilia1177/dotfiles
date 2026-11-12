-- Définition des serveurs LSP.
-- Les binaires sont résolus depuis le PATH
-- (clangd, typescript-language-server, lua-language-server).
-- Le comportement commun (capacités, keymaps, diagnostics) est dans lua/lsp/init.lua.

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--pch-storage=memory",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = {
      "compile_commands.json",
      "compile_flags.txt",
      "CMakeLists.txt",
      ".clangd",
      ".git",
    },
    single_file_support = true,
  },

  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    single_file_support = true,
  },

  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    single_file_support = true,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim" },
          disable = { "undefined-field" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
