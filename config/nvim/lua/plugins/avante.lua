local get_avante_provider_opts = function()
  local P = require("ai-gateway.providers")
  local p = {
    claude = {
      endpoint = P.providers.anthropic.endpoint,
      hide_in_model_selector = true,
    },
    openai = {
      endpoint = P.providers.openai.endpoint,
      hide_in_model_selector = true,
    },
    gemini = {
      endpoint = P.providers.google.endpoint,
      hide_in_model_selector = true,
    },
    ollama = {
      endpoint = P.providers.ollama.endpoint,
      hide_in_model_selector = true,
      disable_tools = true,
    },
    vendors = {},
  }

  -- Add Anthropic models
  for _, model_config in pairs(P.providers.anthropic.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "claude",
      api_key_name = P.providers.anthropic.api_key_name,
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Add OpenAI models
  for _, model_config in pairs(P.providers.openai.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      api_key_name = P.providers.openai.api_key_name,
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Add Google models
  for _, model_config in pairs(P.providers.google.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "gemini",
      api_key_name = P.providers.google.api_key_name,
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Add Cloudflare models
  for _, model_config in pairs(P.providers.cloudflare.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      endpoint = P.providers.cloudflare.endpoint .. "/v1",
      api_key_name = P.providers.cloudflare.api_key_name,
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Add Groq models
  for _, model_config in pairs(P.providers.groq.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      endpoint = P.providers.groq.endpoint,
      api_key_name = P.providers.groq.api_key_name,
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Add Mistral models
  for _, model_config in pairs(P.providers.mistral.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      endpoint = P.providers.mistral.endpoint .. "/v1",
      api_key_name = P.providers.mistral.api_key_name,
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Add Ollama models
  for _, model_config in pairs(P.providers.ollama.models) do
    p.vendors[model_config.vendor_key] = vim.tbl_extend("force", {
      __inherited_from = "ollama",
      model = model_config.model_name,
    }, model_config.params)
  end

  -- Hide these providers in avante.nvim model selector
  for _, name in ipairs({
    "azure",
    "bedrock",
    "cohere",
    "copilot",
    "vertex",
    "vertex_claude" }) do
    p[name] = { hide_in_model_selector = true }
  end

  -- Hide these vendors in avante.nvim model selector
  for _, name in ipairs({
    "aihubmix",
    "aihubmix-claude",
    "bedrock-claude-3.7-sonnet",
    "claude-opus",
    "claude-haiku",
    "openai-gpt-4o-mini",
  }) do
    p[name] = { hide_in_model_selector = true }
  end

  return p
end

local config = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  keys = {
    {
      "<leader>a+",
      function()
        local tree_ext = require("avante.extensions.nvim_tree")
        tree_ext.add_file()
      end,
      desc = "Select file in NvimTree",
      ft = "NvimTree",
    },
    {
      "<leader>a-",
      function()
        local tree_ext = require("avante.extensions.nvim_tree")
        tree_ext.remove_file()
      end,
      desc = "Deselect file in NvimTree",
      ft = "NvimTree",
    },
  },
  config = function()
    dofile(vim.g.base46_cache .. "avante")

    local P = require("ai-gateway.providers")
    local opts = get_avante_provider_opts()

    require("avante").setup(
      vim.tbl_extend("force", opts, {
        provider = P.providers.anthropic.models["claude-4-sonnet-20250514"].vendor_key,
        cursor_applying_provider = P.providers.mistral.models["devstral-small-2505"].vendor_key,
        behaviour = {
          enable_cursor_planning_mode = true,
        },
        selector = {
          exclude_auto_select = { "NvimTree" },
        },
        web_search_engine = {
          provider = "tavily",
          proxy = nil,
        },
        -- RAG service configuration (commented out for now)
        -- rag_service = {
        --   enabled = os.getenv("DISABLE_RAG_SERVICE") == nil,
        --   host_mount = os.getenv("WORKDIR"),
        --   runner = "docker",
        --   provider = "openai",
        --   llm_model = "gpt-4.1-mini",
        --   embed_model = "text-embedding-3-small",
        --   endpoint = providers.ai_gateway .. "/openai",
        -- }
        disabled_tools = {
          "python",
          "run_python",
          "git_commit",
          "delete_file",
          "delete_dir",
        },
      })
    )
  end,
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

return config
