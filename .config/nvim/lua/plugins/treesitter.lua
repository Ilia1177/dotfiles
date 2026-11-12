return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- installation asynchrone des parsers (no-op si déjà installés)
    require("nvim-treesitter").install({
      "bash",
      "c",
      "cpp",
      "css",
      "diff",
      "elixir",
      "heex",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "query",
      "scss",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    })
  end,
}
