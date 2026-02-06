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
    normal = 10000,
    reasoning = 30000,
    slow = 60000, -- e.g. ollama models
    research = 300000,
  },
}

-- Cloudflare AI Gateway URL
M.ai_gateway = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router"

-- Models configuration
---@type { [string]: ProviderConfig }
M.providers = {
  openrouter = {
    endpoint = M.ai_gateway .. "/openrouter",
    api_key_name = "OPENROUTER_API_KEY",
    models = {
      ["claude-4.6-opus"] = {
        model_name = "anthropic/claude-opus-4.6",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-4.5-opus"] = {
        model_name = "anthropic/claude-opus-4.5",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-4.5-sonnet"] = {
        model_name = "anthropic/claude-sonnet-4.5",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-4.5-haiku"] = {
        model_name = "anthropic/claude-4.5-haiku",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["gpt-5.2"] = {
        model_name = "openai/gpt-5.2",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["gpt-5.3-codex"] = {
        model_name = "openai/gpt-5.3-codex",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["gemini-2.5-flash-lite"] = {
        model_name = "google/gemini-2.5-flash-lite",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["gemini-3-pro"] = {
        model_name = "google/gemini-3-pro-preview",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["gemini-3-flash"] = {
        model_name = "google/gemini-3-flash-preview",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["deepseek-v3.2"] = {
        model_name = "deepseek/deepseek-v3.2",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["kimi-k2.5"] = {
        model_name = "moonshotai/kimi-k2.5",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["glm-4.7"] = {
        model_name = "z-ai/glm-4.7",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["glm-4.7-flash"] = {
        model_name = "z-ai/glm-4.7-flash",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["minimax-m2.1"] = {
        model_name = "minimax/minimax-m2.1",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
    },
  },

  -- Ollama models
  ollama = {
    endpoint = "http://localhost:11434",
    models = {
      ["deepseek-r1-8b"] = {
        model_name = "deepseek-r1:8b",
        avante = {
          __inherited_from = "ollama",
          timeout = constants.timeout.slow,
          extra_request_body = {
            options = {
              num_ctx = 2048,
              keep_alive = "5m",
              temperature = 0.6,
            },
          },
        },
      },
      ["qwen3-8b"] = {
        model_name = "qwen3:8b",
        avante = {
          __inherited_from = "ollama",
          timeout = constants.timeout.slow,
          extra_request_body = {
            options = {
              num_ctx = 2048,
              keep_alive = "5m",
              temperature = 0.6,
            },
          },
        },
      },
      ["gemma3-4b"] = {
        model_name = "gemma3:4b",
        avante = {
          __inherited_from = "ollama",
          timeout = constants.timeout.slow,
          extra_request_body = {
            options = {
              num_ctx = 1024,
              keep_alive = "5m",
              temperature = 0.6,
            },
          },
        },
      },
    },
  },
}

return M
