local get_avante_providers = function()
  local A = require("avante.config")
  local P = require("ai-gateway.providers")

  ---@type { [string]: AvanteSupportedProvider }
  local providers = {}

  -- Hide default providers in avante.nvim model selector
  for name in pairs(A._defaults.providers) do
    providers[name] = { hide_in_model_selector = true }
  end

  local zai = P.providers["zai"]
  for _, model in pairs(zai.models) do
    providers["z-ai/" .. model.model_name] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      hide_in_model_selector = false,
      endpoint = zai.endpoint,
      api_key_name = zai.api_key_name,
      model = model.model_name,
      display_name = "z-ai/" .. model.model_name,
      extra_request_body = {
        temperature = 0.6,
      },
    }, model.avante)
  end

  -- local openai = P.providers["openai"]
  -- for _, model in pairs(openai.models) do
  --   providers["openai/" .. model.model_name] = vim.tbl_extend("force", {
  --     __inherited_from = "openai",
  --     hide_in_model_selector = false,
  --     endpoint = openai.endpoint,
  --     api_key_name = openai.api_key_name,
  --     model = model.model_name,
  --     display_name = "openai/" .. model.model_name,
  --     use_response_api = true,
  --     support_previous_response_id = true,
  --     extra_request_body = {
  --       temperature = 0.6,
  --     },
  --   }, model.avante)
  -- end

  local openrouter = P.providers["openrouter"]
  for _, model in pairs(openrouter.models) do
    providers[model.model_name] = vim.tbl_extend("force", {
      __inherited_from = "openai",
      hide_in_model_selector = false,
      endpoint = openrouter.endpoint,
      api_key_name = openrouter.api_key_name,
      model = model.model_name,
      display_name = model.model_name,
      extra_request_body = {
        temperature = 0.6,
      },
    }, model.avante)
  end

  local ollama = P.providers["ollama"]
  for _, model in pairs(ollama.models) do
    providers["ollama/" .. model.model_name] = vim.tbl_extend("force", {
      __inherited_from = "ollama",
      hide_in_model_selector = false,
      endpoint = ollama.endpoint,
      model = model.model_name,
      display_name = "ollama/" .. model.model_name,
    }, model.avante)
  end

  return providers
end

return {
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
      provider = "z-ai/glm-5",
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
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "nvim-tree/nvim-web-devicons",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
