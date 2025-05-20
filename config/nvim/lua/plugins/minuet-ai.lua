--
return {
  "milanglacier/minuet-ai.nvim",
  event = { "BufWritePre" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "hrsh7th/nvim-cmp" },
  },
  config = function()
    local P = require("plugins.ai-gateway.providers")
    require("minuet").setup {
      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = { "NvimTree" },
        keymap = {
          accept = "<A-A>",
          accept_line = "<A-a>",
          accept_n_lines = "<A-z>",
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
        claude = {
          api_key = P.models.anthropic.api_key_name,
          model = "claude-3-5-haiku-latest",
          stream = true,
          max_tokens = 512,
        },
        gemini = {
          api_key = P.models.google.api_key_name,
          model = "gemini-2.0-flash",
          stream = true,
        },
        openai = {
          api_key = P.models.openai.api_key_name,
          model = "gpt-4.1-mini",
          stream = true,
          optional = {
            max_tokens = 512,
          },
        },
        openai_compatible = {
          name = "AI gateway",
          model = "@cf/qwen/qwen2.5-coder-32b-instruct",
          end_point = P.models.cloudflare.endpoint .. "/v1/chat/completions",
          api_key = P.models.cloudflare.api_key_name,
          stream = true,
        }
      },
    }
  end,
}
