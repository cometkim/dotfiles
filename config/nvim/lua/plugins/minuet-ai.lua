local utils = require("utils")

return {
  "milanglacier/minuet-ai.nvim",
  cond = not utils.is_ai_denied(),
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "saghen/blink.cmp" },
  },
  config = function()
    local P = require("configs.ai-providers")

    require("minuet").setup {
      blink = {
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
      request_timeout = 3,
      throttle = 1000,   -- Increase to reduce costs and avoid rate limits
      debounce = 400,    -- Increase to reduce costs and avoid rate limits
      context_window = 32768,
      provider = "openai_fim_compatible",
      provider_options = {
        openai_fim_compatible = {
          name = "deepseek",
          model = "deepseek-v4-flash",
          end_point = P.gateway_endpoint .. "/deepseek/beta/completions",
          api_key = "CF_AIG_TOKEN",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          }
        },
        openai_compatible = {
          name = "opencode_go",
          model = "deepseek-v4-flash",
          end_point = P.gateway_endpoint .. "/custom-opencode-go/zen/go/v1/chat/completions",
          api_key = "CF_AIG_TOKEN",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
            thinking = { type = "disabled" },
          },
        },
        codestral = {
          name = "codestral",
          model = "codestral-latest",
          end_point = P.gateway_endpoint .. "/custom-codestral/v1/fim/completions",
          api_key = "CF_AIG_TOKEN",
          stream = true,
          optional = {
            max_tokens = 256,
            stop = { '\n\n' },
          },
        },
      },
    }
  end,
}
