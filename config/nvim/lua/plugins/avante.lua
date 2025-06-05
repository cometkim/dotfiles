local get_provider_id = function(provider, model)
  return provider .. "-" .. model
end

local get_avante_providers = function()
  local A = require("avante.config")
  local P = require("ai-gateway.providers")

  ---@type { [string]: AvanteSupportedProvider }
  local providers = {}

  -- Hide default providers in avante.nvim model selector
  for name in pairs(A._defaults.providers) do
    providers[name] = { hide_in_model_selector = true }
  end

  for provider, provider_config in pairs(P.providers) do
    for model, model_config in pairs(provider_config.models) do
      local id = get_provider_id(provider, model)
      providers[id] = vim.tbl_extend("force", {
        model = model_config.model_name,
        display_name = provider .. "/" .. model,
        endpoint = provider_config.endpoint,
        api_key_name = provider_config.api_key_name,
        hide_in_model_selector = false,
      }, model_config.avante)
    end
  end

  return providers
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

    require("avante").setup {
      mode = "agentic",
      providers = get_avante_providers(),
      provider = get_provider_id("anthropic", "claude-4-sonnet"),
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
    }
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
    "nvim-tree/nvim-web-devicons",
    "HakonHarnes/img-clip.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
}

return config
