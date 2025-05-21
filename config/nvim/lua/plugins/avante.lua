local vendor = (function()
  local counters = {}
  return function(name)
    local count = counters[name] or 0
    local id = name .. "-" .. count
    counters[name] = count + 1
    return id
  end
end)()

local get_avante_provider_opts = function()
  local P = require("plugins.ai-gateway.providers")
  local p = {
    claude = {
      endpoint = P.models.anthropic.endpoint,
      hide_in_model_selector = true,
    },
    openai = {
      endpoint = P.models.openai.endpoint,
      hide_in_model_selector = true,
    },
    gemini = {
      endpoint = P.models.google.endpoint,
      hide_in_model_selector = true,
    },
    ollama = {
      endpoint = P.models.ollama.endpoint,
      hide_in_model_selector = true,
      disable_tools = true,
    },
    vendors = {},
  }

  -- Add Anthropic models
  for model_name, model_config in pairs(P.models.anthropic.models) do
    local vendor_name = vendor("anthropic")
    p.vendors[vendor_name] = vim.tbl_extend("force", {
      __inherited_from = "claude",
      api_key_name = P.models.anthropic.api_key_name,
      model = model_name,
    }, model_config)
  end

  -- Add OpenAI models
  for model_name, model_config in pairs(P.models.openai.models) do
    local vendor_name = vendor("openai")
    p.vendors[vendor_name] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      api_key_name = P.models.openai.api_key_name,
      model = model_name,
    }, model_config)
  end

  -- Add Google models
  for model_name, model_config in pairs(P.models.google.models) do
    local vendor_name = vendor("google")
    p.vendors[vendor_name] = vim.tbl_extend("force", {
      __inherited_from = "gemini",
      api_key_name = P.models.google.api_key_name,
      model = model_name,
    }, model_config)
  end

  -- Add Cloudflare models
  for model_name, model_config in pairs(P.models.cloudflare.models) do
    local vendor_name = vendor("cloudflare")
    p.vendors[vendor_name] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      endpoint = P.models.cloudflare.endpoint .. "/v1",
      api_key_name = P.models.cloudflare.api_key_name,
      model = model_name,
    }, model_config)
  end

  -- Add Groq models
  for model_name, model_config in pairs(P.models.groq.models) do
    local vendor_name = vendor("groq")
    p.vendors[vendor_name] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      api_key_name = P.models.groq.api_key_name,
      model = model_name,
    }, model_config)
  end

  -- Add Ollama models
  for model_name, model_config in pairs(P.models.ollama.models) do
    local vendor_name = vendor("ollama")
    p.vendors[vendor_name] = vim.tbl_extend("force", {
      __inherited_from = "ollama",
      model = model_name,
    }, model_config)
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

    local opts = get_avante_provider_opts()

    require("avante").setup(
      vim.tbl_extend("force", opts, {
        provider = "google-0",
        cursor_applying_provider = "cloudflare-0",
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
        disabled_tools = { "python" },
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
