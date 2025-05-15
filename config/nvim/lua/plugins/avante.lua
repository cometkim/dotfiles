local vendor = (function()
  local count = 0
  return function(name)
    name = count .. "-" .. name
    count = count + 1
    return name
  end
end)()

local config = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "0-anthropic",
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
      endpoint = "http://localhost:11434",
      hide_in_model_selector = true,
      disable_tools = true,
    },
    vendors = {
      [vendor("anthropic")] = {
        __inherited_from = "claude",
        model = "claude-3-5-sonnet-20241022",
        timeout = 60000,
        temperature = 0,
        max_tokens = 8192,
        disabled_tools = { "python" },
      },
      [vendor("anthropic")] = {
        __inherited_from = "claude",
        model = "claude-3-7-sonnet-20250219",
        timeout = 60000,
        temperature = 0,
        max_tokens = 20480,
        disabled_tools = { "python" },
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
        model = "qwen3:8b",
        timeout = 60000,
        options = {
          temperature = 0,
          num_ctx = 2048,
          keep_alive = "5m",
        },
      },
      [vendor("ollama")] = {
        __inherited_from = "ollama",
        model = "gemma3:4b",
        timeout = 60000,
        options = {
          temperature = 0,
          num_ctx = 1024,
          keep_alive = "5m",
        },
      },
    },
    web_search_engine = {
      provider = "tavily",
      proxy = nil,
    },
    -- Don't use RAG service yet.
    -- rag_service = {
    --   enabled = os.getenv("DISABLE_RAG_SERVICE") == nil,
    --   host_mount = os.getenv("WORKDIR"),
    --   runner = "docker",
    --   provider = "openai",
    --   llm_model = "gpt-4.1-mini",
    --   embed_model = "text-embedding-3-small",
    --   endpoint = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router/openai",
    -- },
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
  "azure",
  "bedrock",
  "cohere",
  "copilot",
  "vertex", "vertex_claude"
}
for _, name in ipairs(hide_providers) do
  config.opts[name] = { hide_in_model_selector = true }
end

local hide_vendors = {
  "aihubmix", "aihubmix-claude",
  "bedrock-claude-3.7-sonnet",
  "claude-opus", "claude-haiku",
  "openai-gpt-4o-mini",
}
for _, name in ipairs(hide_vendors) do
  config.opts.vendors[name] = { hide_in_model_selector = true }
end

return config
