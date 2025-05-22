local M = {}

-- Cloudflare AI Gateway URL
M.ai_gateway = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router"

-- Models configuration
M.providers = {
  -- Anthropic models
  anthropic = {
    endpoint = M.ai_gateway .. "/anthropic",
    api_key_name = "ANTHROPIC_API_KEY",
    models = {
      ["claude-4-sonnet-20250514"] = {
        params = {
          timeout = 30000,
          temperature = 0,
          stream = true,
        },
      },
      ["claude-3-5-haiku-latest"] = {
        params = {
          timeout = 10000,
          temperature = 0,
          stream = true,
        },
      },
    },
  },

  -- OpenAI models
  openai = {
    endpoint = M.ai_gateway .. "/openai",
    api_key_name = "OPENAI_API_KEY",
    models = {
      ["gpt-4.1"] = {
        params = {
          timeout = 10000,
          temperature = 0,
          stream = true,
        },
      },
      ["gpt-4.1-mini"] = {
        params = {
          timeout = 10000,
          temperature = 0,
          stream = true,
        },
      },
      ["o4-mini"] = {
        params = {
          timeout = 30000,
          temperature = 0,
          stream = true,
        },
      },
      -- Only exist on ChatGPT app...?
      -- ["o4-mini-high"] = {
      --   params = {
      --     timeout = 60000, temperature = 0,
      --     max_completion_tokens = 8192,
      --   },
      -- },
    },
  },

  -- Groq models
  groq = {
    endpoint = M.ai_gateway .. "/groq",
    api_key_name = "GROQ_API_KEY",
    models = {
      ["qwen-qwq-32b"] = {
        params = {
          timeout = 10000,
          stream = true,
          temperature = 0,
          max_completion_tokens = 32768,
        },
      },
      ["deepseek-r1-distill-llama-70b"] = {
        params = {
          timeout = 10000,
          stream = true,
          temperature = 0,
          max_completion_tokens = 32768,
        },
      },
      ["llama-3.3-70b-versatile"] = {
        params = {
          timeout = 10000,
          stream = true,
          temperature = 0,
          max_completion_tokens = 32768,
        },
      },
      ["meta-llama/llama-4-scout-17b-16e-instruct"] = {
        params = {
          timeout = 10000,
          stream = true,
          temperature = 0,
          max_completion_tokens = 8192,
        },
      },
      ["meta-llama/llama-4-maverick-17b-128e-instruct"] = {
        params = {
          timeout = 10000,
          stream = true,
          temperature = 0,
          max_completion_tokens = 8192,
        },
      },
    },
  },

  -- Google AI Studio - Gemini models
  google = {
    endpoint = M.ai_gateway .. "/google-ai-studio/v1beta/models",
    api_key_name = "GEMINI_API_KEY",
    models = {
      ["gemini-2.5-flash-preview-05-20"] = {
        params = {
          timeout = 10000,
          temperature = 0,
          disable_tools = true,
          generationConfig = {
            thinkingConfig = {
              thinkingBudget = 0,
            },
          },
        },
      },
      ["gemini-2.5-pro-preview-05-06"] = {
        params = {
          timeout = 30000,
          temperature = 0,
        },
      },
      ["gemini-2.0-flash"] = {
        params = {
          timeout = 10000,
          temperature = 0,
        },
      },
      ["gemini-2.0-flash-lite"] = {
        params = {
          timeout = 10000,
          temperature = 0,
        },
      },
      ["gemma-3n-e4b-it"] = {
        params = {
          timeout = 10000,
          temperature = 0,
          disable_tools = true,
        },
      },
    },
  },

  -- Cloudflare models
  --
  -- Too expensive and slow -- prefer Groq
  cloudflare = {
    endpoint = M.ai_gateway .. "/workers-ai",
    api_key_name = "CLOUDFLARE_AI_API_TOKEN",
    models = {
      ["@cf/meta/llama-3.3-70b-instruct-fp8-fast"] = {
        params = {
          disable_tools = true,
        },
      },
      ["@cf/meta/llama-4-scout-17b-16e-instruct"] = {
        params = {
          disable_tools = true,
        },
      },
      ["@cf/qwen/qwen2.5-coder-32b-instruct"] = {
        params = {
          disable_tools = true,
        },
      },
      ["@cf/qwen/qwq-32b"] = {
        params = {
          disable_tools = true,
        },
      },
    },
  },

  mistral = {
    endpoint = M.ai_gateway .. "/mistral",
    api_key_name = "MISTRAL_API_KEY",
    models = {
      ["codestral-latest"] = {
        params = {
          disable_tools = true,
          max_tokens = 4096,
        },
      },
      ["devstral-small-2505"] = {
        params = {
          disable_tools = true,
          max_tokens = 4096,
        },
      },
    },
  },

  -- Ollama models
  ollama = {
    endpoint = "http://localhost:11434",
    models = {
      ["qwen3:8b"] = {
        params = {
          timeout = 60000,
          options = {
            temperature = 0,
            num_ctx = 2048,
            keep_alive = "5m",
          },
          disable_tools = true,
        },
      },
      ["gemma3:4b"] = {
        params = {
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
  },
}

local vendor_key = (function()
  local counters = {}
  return function(name)
    local count = counters[name] or 0
    local id = name .. "-" .. count
    counters[name] = count + 1
    return id
  end
end)()

for vendor_name, vendor_tbl in pairs(M.providers) do
  for model_name, model_tbl in pairs(vendor_tbl.models) do
    model_tbl.vendor = vendor_name
    model_tbl.vendor_key = vendor_key(vendor_name)
    if not model_tbl.model_name then
      model_tbl.model_name = model_name
    end
  end
end

return M
