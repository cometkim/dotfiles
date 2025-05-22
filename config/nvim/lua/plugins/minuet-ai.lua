return {
  "milanglacier/minuet-ai.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "hrsh7th/nvim-cmp" },
  },
  config = function()
    local P = require("ai-gateway.providers")
    require("minuet").setup {
      cmp = {
        enable_auto_complete = true,
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = {
          "NvimTree",
          "Telescope",
          "TelescopePrompt",
          "DressingInput",
          "OverseerForm",
          "AvanteInput",
        },
        keymap = {
          accept = "<Tab>",
          -- accept_line = "<A-a>",
          -- accept_n_lines = "<A-z>",
          prev = "<A-[>",
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
      -- Cannot use openai_fim_compatible
      --
      -- Because Cloudflare AI gateway doesn't support `/completions` endpoint,
      -- but only the `/chat/completions` endpoint.
      provider = "openai_compatible",
      request_timeout = 3,
      throttle = 600, -- Increase to reduce costs and avoid rate limits
      debounce = 300, -- Increase to reduce costs and avoid rate limits
      context_window = 32768,
      provider_options = {
        -- Endpoint customization isn't supported yet.
        -- See https://github.com/milanglacier/minuet-ai.nvim/issues/92
        --
        -- claude = {
        --   api_key = P.providers.anthropic.api_key_name,
        --   model = "claude-3-5-haiku-latest",
        --   stream = true,
        --   max_tokens = 512,
        -- },
        -- gemini = {
        --   api_key = P.providers.google.api_key_name,
        --   model = "gemini-2.0-flash-lite",
        --   stream = true,
        --   max_tokens = 512,
        -- },
        -- openai = {
        --   api_key = P.providers.openai.api_key_name,
        --   model = "gpt-4.1-nano",
        --   stream = true,
        --   optional = {
        --     max_tokens = 512,
        --   },
        -- },
        openai_compatible = {
          name = "devstral",
          model = "devstral-small-2505",
          end_point = P.providers.mistral.endpoint .. "/v1/chat/completions",
          api_key = P.providers.mistral.api_key_name,
          stream = true,
          optional = {
            max_tokens = 512,
          },
        },
      },
    }
  end,
}
