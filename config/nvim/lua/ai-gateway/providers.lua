---@module "avante"

local M = {}

---@class ProviderConfig
---@field endpoint string
---@field api_key_name string?
---@field models { [string]: ModelConfig }

---@class ModelConfig
---@field model_name string
---@field avante AvanteSupportedProvider?

local constants = {
  timeout = {
    fast = 3000,
    slow = 60000, -- e.g. ollama models
    normal = 10000,
    reasoning = 30000,
  },
}

-- Cloudflare AI Gateway URL
M.ai_gateway = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router"

-- Models configuration
---@type { [string]: ProviderConfig }
M.providers = {
  -- Anthropic models
  anthropic = {
    endpoint = M.ai_gateway .. "/anthropic",
    api_key_name = "ANTHROPIC_API_KEY",
    models = {
      ["claude-4-sonnet"] = {
        model_name = "claude-4-sonnet-20250514",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
        },
      },
      ["claude-3.5-haiku"] = {
        model_name = "claude-3-5-haiku-latest",
        avante = {
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
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
        model_name = "gpt-4.1",
        avante = {
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
        },
      },
      ["gpt-4.1-mini"] = {
        model_name = "gpt-4.1-mini",
        avante = {
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
        },
      },
      ["o3"] = {
        model_name = "o3",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
        },
      },
      ["o4-mini"] = {
        model_name = "o4-mini",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
        },
      },
      ["o4-mini-high"] = {
        model_name = "o4-mini",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
            stream = true,
          },
        },
      },
    },
  },

  -- Groq models
  groq = {
    endpoint = M.ai_gateway .. "/groq",
    api_key_name = "GROQ_API_KEY",
    models = {
      ["qwq-32b"] = {
        model_name = "qwen-qwq-32b",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
            max_completion_tokens = 32768,
          },
        },
      },
      ["deepseek-r1-70b"] = {
        model_name = "deepseek-r1-distill-llama-70b",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
            max_completion_tokens = 32768,
          },
        },
      },
      ["llama-3.3-70b"] = {
        model_name = "llama-3.3-70b-versatile",
        avante = {
          timeout = constants.timeout.normal,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
            max_completion_tokens = 32768,
          },
        },
      },
      ["llama-4-scout-17b"] = {
        model_name = "meta-llama/llama-4-scout-17b-16e-instruct",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
            max_completion_tokens = 8192,
          },
        },
      },
      ["llama-4-maverick-17b"] = {
        model_name = "meta-llama/llama-4-maverick-17b-128e-instruct",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
            max_completion_tokens = 8192,
          },
        },
      },
    },
  },

  -- Google AI Studio - Gemini models
  google = {
    endpoint = M.ai_gateway .. "/google-ai-studio/v1beta/models",
    api_key_name = "GEMINI_API_KEY",
    models = {
      ["gemini-2.5-flash-no-think"] = {
        model_name = "gemini-2.5-flash-preview-05-20",
        avante = {
          timeout = constants.timeout.normal,
          disable_tools = true,
          extra_request_body = {
            temperature = 0.6,
            generationConfig = {
              thinkingConfig = {
                thinkingBudget = 0,
              },
            },
          },
        },
      },
      ["gemini-2.5-flash"] = {
        model_name = "gemini-2.5-flash-preview-05-20",
        avante = {
          timeout = constants.timeout.reasoning,
          disable_tools = true,
          extra_request_body = {
            temperature = 0.6,
          },
        },
      },
      ["gemini-2.5-pro-preview-05-06"] = {
        model_name = "gemini-2.5-pro-preview-05-06",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
          },
        },
      },
      ["gemini-2.0-flash"] = {
        model_name = "gemini-2.0-flash",
        avante = {
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
          },
        }
      },
      ["gemini-2.0-flash-lite"] = {
        model_name = "gemini-2.0-flash-lite",
        avante = {
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
          },
        },
      },
      ["gemma-3n"] = {
        model_name = "gemma-3n-e4b-it",
        avante = {
          timeout = constants.timeout.fast,
          disable_tools = true,
          extra_request_body = {
            temperature = 0.6,
          },
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
      ["llama-3.3-70b"] = {
        model_name = "@cf/meta/llama-3.3-70b-instruct-fp8-fast",
        avante = {
          timeout = constants.timeout.normal,
          disable_tools = true,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
          },
        },
      },
      ["llama-4-scout-17b"] = {
        model_name = "@cf/meta/llama-4-scout-17b-16e-instruct",
        avante = {
          timeout = constants.timeout.reasoning,
          disable_tools = true,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
          },
        },
      },
      ["qwen-2.5-coder-32b"] = {
        model_name = "@cf/qwen/qwen2.5-coder-32b-instruct",
        avante = {
          timeout = constants.timeout.normal,
          disable_tools = true,
          extra_request_body = {
            stream = true,
            temperature = 0,
          },
        },
      },
      ["qwq-32b"] = {
        model_name = "@cf/qwen/qwq-32b",
        avante = {
          timeout = constants.timeout.reasoning,
          disable_tools = true,
          extra_request_body = {
            stream = true,
            temperature = 0.6,
          },
        },
      },
    },
  },

  mistral = {
    endpoint = M.ai_gateway .. "/mistral",
    api_key_name = "MISTRAL_API_KEY",
    models = {
      ["codestral"] = {
        model_name = "codestral-latest",
        avante = {
          timeout = constants.timeout.normal,
          disable_tools = true,
        },
      },
      ["devstral"] = {
        model_name = "devstral-small-2505",
        avante = {
          timeout = constants.timeout.normal,
          disable_tools = true,
        },
      },
    },
  },

  -- Ollama models
  ollama = {
    endpoint = "http://localhost:11434",
    models = {
      ["qwen3-8b"] = {
        model_name = "qwen3:8b",
        avante = {
          timeout = constants.timeout.slow,
          disable_tools = true,
          keep_alive = "5m",
          extra_request_body = {
            temperature = 0.6,
            num_ctx = 2048,
          },
        },
      },
      ["gemma3-4b"] = {
        model_name = "gemma3:4b",
        avante = {
          timeout = constants.timeout.slow,
          disable_tools = true,
          keep_alive = "5m",
          extra_request_body = {
            temperature = 0.6,
            num_ctx = 1024,
          },
        },
      },
    },
  },
}

local get_config = function(provider, model)
  local p = M.providers[provider]
  if not p then
    error("Provider not found: " .. provider)
  end
  local m = p.models[model]
  if not m then
    error("Model not found: " .. model)
  end
  return {
    provider = p,
    model = m,
  }
end

---@param provider string
---@param model string
M.get_provider_id = function(provider, model)
  return provider .. "-" .. model
end

---@param provider string
---@param model string
---@return AvanteSupportedProvider
M.get_avante_provider_config = function(provider, model)
  local config = get_config(provider, model)
  return vim.tbl_extend("force", {
    model = config.model.model_name,
    display_name = provider .. "/" .. model,
    api_key_name = config.provider.api_key_name,
  }, config.model.avante)
end

return M
