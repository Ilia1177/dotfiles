-- return {
--   "L3MON4D3/LuaSnip",
--   version = "v2.*",
--   build = "make install_jsregexp",
--   config = function()
--     local luasnip = require("luasnip")
--
--     -- load vscode-style snippets
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     -- optional: your own snippets
--     -- luasnip.add_snippets("lua", {
--     --   luasnip.snippet("fn", {
--     --     luasnip.text_node("function("),
--     --     luasnip.insert_node(1),
--     --     luasnip.text_node(")"),
--     --   }),
--     -- })
--
--     -- keymaps to jump inside snippets
--     vim.keymap.set({ "i", "s" }, "<Tab>", function()
--       if luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         return "<Tab>"
--       end
--     end, { expr = true })
--
--     vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
--       if luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         return "<S-Tab>"
--       end
--     end, { expr = true })
--   end,
-- }
return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets", -- make sure snippets are loaded *before* config
  },
  config = function()
    local luasnip = require("luasnip")

    -- load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- optional: enable autosnippets
    luasnip.config.setup({ enable_autosnippets = true })


	local cmp = require("cmp")

	-- Expand or jump forward in snippet
	vim.keymap.set({ "i", "s" }, "<S-Tab>", function(fallback)
	  if cmp.visible() then
		cmp.select_next_item()
	  elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	  else
		fallback()
	  end
	end, { expr = true, silent = true })

	-- -- Jump backward in snippet
	-- vim.keymap.set({ "i", "s" }, "<S-Tab>", function(fallback)
	--   if cmp.visible() then
	-- 	cmp.select_prev_item()
	--   elseif luasnip.jumpable(-1) then
	-- 	luasnip.jump(-1)
	--   else
	-- 	fallback()
	--   end
	-- end, { expr = true, silent = true })

  end,
}


