---@module "avante"

local M = {}

---@class ProviderConfig
---@field endpoint string?
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

-- Models configuration
---@type { [string]: ProviderConfig }
M.providers = {
  -- Purchased GLM Coding Plan
  zai = {
    endpoint = "https://api.z.ai/api/coding/paas/v4",
    api_key_name = "ZAI_API_KEY",
    models = {
      ["glm-5.0"] = {
        model_name = "glm-5",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["glm-4.7-flash"] = {
        model_name = "glm-4.7-flash",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
    },
  },

  -- Purchased GhatGPT Plan
  openai = {
    -- It's better to wait for Avante.nvim navively support codex endpoint.
    --
    -- endpoint = "https://chatgpt.com/backend-api/codex",
    -- api_key_name = "cmd:cat ~/.codex/auth.json | jq -j .tokens.access_token",
    --
    models = {
      ["gpt-5.3-codex"] = {
        model_name = "gpt-5.3-codex",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
      ["gpt-5.3-codex-spark"] = {
        model_name = "gpt-5.3-codex-spark",
        avante = {
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 1,
          },
        },
      },
    },
  },

  -- Un-purchased models w/ on-demand billing
  openrouter = {
    -- Pass-through to Cloudflare AI Gateway
    endpoint = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/router" .. "/openrouter",
    api_key_name = "OPENROUTER_API_KEY",
    models = {
      ["claude-opus-4.6"] = {
        model_name = "anthropic/claude-opus-4.6",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-sonnet-4.6"] = {
        model_name = "anthropic/claude-sonnet-4.6",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["claude-haiku-4.5"] = {
        model_name = "anthropic/claude-4.5-haiku",
        avante = {
          timeout = constants.timeout.normal,
        },
      },
      ["gemini-3.1-pro"] = {
        model_name = "google/gemini-3.1-pro-preview",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      ["gemini-3.0-flash"] = {
        model_name = "google/gemini-3-flash-preview",
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

    },
  },

  -- Powered by Backend.AI GO
  backend_ai = {
    endpoint = "http://localhost:39080/v1",
    models = {
      ["unsloth/Qwen3.5-9B"] = {
        model_name = "unsloth/Qwen3.5-9B",
        avante = {
          timeout = constants.timeout.slow,
        },
      },
    },
  },
}

return M
