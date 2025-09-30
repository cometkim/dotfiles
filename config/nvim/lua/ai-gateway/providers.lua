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
      ["coder"] = {
        model_name = "@preset/coder",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["instruct"] = {
        model_name = "@preset/instruct",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["instruct-thinking"] = {
        model_name = "@preset/instruct-thinking",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["claude-4.5-sonnet"] = {
        model_name = "anthropic/claude-sonnet-4.5",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-4.1-opus"] = {
        model_name = "anthropic/claude-opus-4.1",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-3.5-haiku"] = {
        model_name = "anthropic/claude-3.5-haiku",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["gpt-5"] = {
        model_name = "openai/gpt-5",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["gpt-5-chat"] = {
        model_name = "openai/gpt-5-chat",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["gpt-5-mini"] = {
        model_name = "openai/gpt-5-mini",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["gpt-5-nano"] = {
        model_name = "openai/gpt-5-nano",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["o3"] = {
        model_name = "openai/o3",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["gemini-2.5-flash-lite"] = {
        model_name = "google/gemini-2.5-flash-lite",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["gemini-2.5-flash"] = {
        model_name = "google/gemini-2.5-flash",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["gemini-2.5-pro"] = {
        model_name = "google/gemini-2.5-pro",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["codestral"] = {
        model_name = "mistralai/codestral-2508",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["devstral-small"] = {
        model_name = "mistralai/devstral-small",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["devstral-medium"] = {
        model_name = "mistralai/devstral-medium",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["qwen3-coder"] = {
        model_name = "qwen/qwen3-coder",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["qwen3"] = {
        model_name = "qwen/qwen3-235b-a22b-2507",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["qwen3-thinking"] = {
        model_name = "qwen/qwen3-235b-a22b-thinking-2507",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["kimi-k2"] = {
        model_name = "moonshotai/kimi-k2-0905",
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
