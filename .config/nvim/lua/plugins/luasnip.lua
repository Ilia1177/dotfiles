return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  event = { "InsertEnter", "CmdlineEnter" },
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local luasnip = require("luasnip")

    -- snippets façon VS Code (friendly-snippets inclus)
    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.config.setup({ enable_autosnippets = true })
  end,
}
