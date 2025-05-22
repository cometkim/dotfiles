local M = {}

-- Cloudflare AI Gateway URL
M.ai_gateway = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router"

-- Models configuration
M.models = {
  -- Anthropic models
  anthropic = {
    endpoint = M.ai_gateway .. "/anthropic",
    api_key_name = "ANTHROPIC_API_KEY",
    models = {
      ["claude-3-7-sonnet-latest"] = {
        timeout = 30000,
        temperature = 0,
        max_tokens = 8192,
      },
      ["claude-3-5-haiku-latest"] = {
        timeout = 10000,
        temperature = 0,
        max_tokens = 8192,
      },
    },
  },

  -- OpenAI models
  openai = {
    endpoint = M.ai_gateway .. "/openai",
    api_key_name = "OPENAI_API_KEY",
    models = {
      ["gpt-4.1"] = {
        timeout = 10000,
        temperature = 0,
        max_completion_tokens = 8192,
      },
      ["gpt-4.1-mini"] = {
        timeout = 10000,
        temperature = 0,
        max_completion_tokens = 8192,
      },
      ["o4-mini"] = {
        timeout = 30000,
        temperature = 0,
        max_completion_tokens = 8192,
      },
      -- Only exist on ChatGPT app...?
      -- ["o4-mini-high"] = {
      --   timeout = 60000,
      --   temperature = 0,
      --   max_completion_tokens = 8192,
      -- },
    },
  },

  -- Groq models
  groq = {
    endpoint = M.ai_gateway .. "/groq",
    api_key_name = "GROQ_API_KEY",
    models = {
      ["llama-3.3-70b-versatile"] = {
        max_completion_tokens = 32768,
      },
    },
  },

  -- Google AI Studio - Gemini models
  google = {
    endpoint = M.ai_gateway .. "/google-ai-studio/v1beta/models",
    api_key_name = "GEMINI_API_KEY",
    models = {
      ["gemini-2.5-flash-preview-05-20"] = {
        timeout = 10000,
        temperature = 0,
      },
      ["gemini-2.5-pro-preview-05-06"] = {
        timeout = 30000,
        temperature = 0,
      },
      ["gemini-2.0-flash"] = {
        timeout = 10000,
        temperature = 0,
      },
      ["gemini-2.0-flash-lite"] = {
        timeout = 10000,
        temperature = 0,
      },
      ["gemma-3n-e4b-it"] = {
        timeout = 10000,
        temperature = 0,
        disable_tools = true,
      },
    },
  },

  -- Cloudflare models
  cloudflare = {
    endpoint = M.ai_gateway .. "/workers-ai",
    api_key_name = "CLOUDFLARE_AI_API_TOKEN",
    models = {
      ["@cf/meta/llama-3.3-70b-instruct-fp8-fast"] = {
        disable_tools = true,
      },
      ["@cf/meta/llama-4-scout-17b-16e-instruct"] = {
        disable_tools = true,
      },
      ["@cf/qwen/qwen2.5-coder-32b-instruct"] = {
        disable_tools = true,
      },
      ["@cf/qwen/qwq-32b"] = {
        disable_tools = true,
      },
    },
  },

  mistral = {
    endpoint = M.ai_gateway .. "/mistral",
    api_key_name = "MISTRAL_API_KEY",
    models = {
      ["codestral-latest"] = {
        disable_tools = true,
        max_tokens = 4096,
      },
      ["devstral-small-2505"] = {
        disable_tools = true,
        max_tokens = 4096,
      },
    },
  },

  -- Ollama models
  ollama = {
    endpoint = "http://localhost:11434",
    models = {
      ["qwen3:8b"] = {
        timeout = 60000,
        options = {
          temperature = 0,
          num_ctx = 2048,
          keep_alive = "5m",
        },
        disable_tools = true,
      },
      ["gemma3:4b"] = {
        timeout = 60000,
        options = {
          temperature = 0,
          num_ctx = 1024,
          keep_alive = "5m",
        },
        disable_tools = true,
      },
    },
  },
}

return M
