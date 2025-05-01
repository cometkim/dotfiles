local vendor = (function()
  local count = 0
  return function(name)
    name = count .. "-" .. name
    count = count + 1
    return name
  end
end)()

local default_vendor = vendor("anthropic")
local config = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = default_vendor,
    claude = {
      endpoint = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router/anthropic",
      hide_in_model_selector = true,
    },
    openai = {
      endpoint = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router/openai",
      hide_in_model_selector = true,
    },
    gemini = {
      endpoint =
      "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router/google-ai-studio/v1beta/models",
      hide_in_model_selector = true,
    },
    ollama = {
      endpoint = "http://127.0.0.1:11434",
      hide_in_model_selector = true,
      options = {
        temperature = 0,
        num_ctx = 20480,
        keep_alive = "5m",
      },
    },

    vendors = {
      [default_vendor] = {
        __inherited_from = "claude",
        model = "claude-3-7-sonnet-20250219",
        timeout = 60000,
        temperature = 0,
        max_tokens = 20480,
      },
      [vendor("openai")] = {
        __inherited_from = "openai",
        model = "gpt-4.1",
        timeout = 30000,
        temperature = 0,
        max_completion_tokens = 8192,
      },
      [vendor("openai")] = {
        __inherited_from = "openai",
        model = "gpt-4.1-mini",
        timeout = 30000,
        temperature = 0,
        max_completion_tokens = 8192,
      },
      -- https://github.com/yetone/avante.nvim/issues/1890
      -- [vendor("openai")] = {
      --   __inherited_from = "openai",
      --   model = "o4-mini",
      --   timeout = 60000,
      --   temperature = 0,
      --   max_completion_tokens = 8192,
      --   reasoning_effort = "medium",
      -- },
      [vendor("google")] = {
        __inherited_from = "gemini",
        model = "gemini-2.0-flash",
        timeout = 30000,
        temperature = 0,
        max_tokens = 20480,
      },
      [vendor("google")] = {
        __inherited_from = "gemini",
        model = "gemini-2.5-flash-preview-04-17",
      },
      [vendor("google")] = {
        __inherited_from = "gemini",
        model = "gemini-2.5-pro-preview-03-25",
        timeout = 60000,
      },
      [vendor("ollama")] = {
        __inherited_from = "ollama",
        model = "qwen3:latest",
        timeout = 60000,
      },
      [vendor("ollama")] = {
        __inherited_from = "ollama",
        model = "gemma3:latest",
        timeout = 60000,
      },

    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",
    "HakonHarnes/img-clip.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
}

local hide_providers = {
  "aihubmix", "aihubmix-claude", "azure", "bedrock",
  "bedrock-claude-3.7-sonnet", "cohere", "copilot",
  "claude-opus", "claude-haiku", "openai-gpt-4o-mini",
  "vertex", "vertex_claude"
}
for _, name in ipairs(hide_providers) do
  config.opts[name] = { hide_in_model_selector = true }
end

return config
