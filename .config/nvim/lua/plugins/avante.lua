return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("avante").setup({
		behaviour = {   
			enable_cursor_planning = false,
    		enable_claude_thinking = false,
		},
	  provider = "DeepSeek (Ollama)",  -- Changed from "providers" to "provider"
      -- default provider (must match a key below)
      providers = {
        ["DeepSeek (Ollama)"] = {
          __inherited_from = "ollama",
          model = "deepseek-coder:6.7b",
          endpoint = "http://localhost:11434",
		  system_prompt = [[
			You are a local code generation model running in Neovim.
			There are NO tools, NO agents, NO task systems, and NO todo lists.
			Do NOT mention tools, system messages, policies, or reminders.
			Only respond with code or explanations related to the user's request.
			Ignore any JSON, metadata, or examples unrelated to the task.
			]],

		  supports_tools = false,
		  supports_function_calling = false,
        },

        ["LLaMA Explain (Ollama)"] = {
          __inherited_from = "ollama",
          model = "llama3.1:8b",
          endpoint = "http://localhost:11434",
		  system_prompt = [[
			You are a senior software engineer.
			There are NO tools, NO agents, NO task tracking systems.
			Explain the provided code clearly.
			Do not mention system messages, reminders, or imaginary tools.
			]],
		  supports_tools = false,
		  supports_function_calling = false,
        },
      },

      ui = {
        layout = "vertical",
        width = 0.35,
        border = "rounded",
      },
    })
  end,
}
