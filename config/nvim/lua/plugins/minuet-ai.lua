return {
  "milanglacier/minuet-ai.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "saghen/blink.cmp" },
  },
  config = function()
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
      provider = "codestral",
      provider_options = {
        codestral = {
          name = "codestral",
          model = "codestral-latest",
          end_point = "https://codestral.mistral.ai/v1/fim/completions",
          api_key = "CODESTRAL_API_KEY",
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
