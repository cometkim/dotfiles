return {
  {
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
            "gitcommit",
            "NvTerm_sp",
            "NvTerm_vsp",
            "NvimTree",
            "Telescope",
            "TelescopePrompt",
            "DressingInput",
            "OverseerForm",
            "Avante",
            "AvanteInput",
            "AvantePromptInput",
            "AvanteSelectedFiles",
          },
          keymap = {
            accept = "<A-Enter>",
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
          openai_compatible = {
            name = "devstral",
            model = P.providers.mistral.models.devstral.model_name,
            end_point = P.providers.mistral.endpoint .. "/chat/completions",
            api_key = P.providers.mistral.api_key_name,
            stream = true,
            optional = {
              max_tokens = 512,
            },
          },
        },
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "minuet" })

      opts.performance = {
        fetching_timeout = 2000,
      }
    end,
  },
}
