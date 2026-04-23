---@module "avante"

local M = {}

---@class ProviderConfig
---@field endpoint string?
---@field api_key_name string?
---@field models { [string]: ModelConfig }
---@field extra_headers table?
---@field parse_curl_opts (fun(self: AvanteProviderFunctor, prompt_opts: AvantePromptOptions): (AvanteCurlOutput | nil))?

---@class ModelConfig
---@field model_name string
---@field avante AvanteProvider?

local constants = {
  timeout = {
    fast = 3000,
    normal = 10000,
    reasoning = 30000,
    slow = 60000, -- e.g. ollama models
    research = 300000,
  },
}

local gateway_authorization_token = os.getenv("CF_AIG_TOKEN")

---@type table<string, string>
local gateway_authorization_headers = {}
if gateway_authorization_token then
  gateway_authorization_headers = {
    ["cf-aig-authorization"] = "Bearer " .. gateway_authorization_token,
  }
end

-- Models configuration
---@type { [string]: ProviderConfig }
M.providers = {
  glm_coding_plan = {
    endpoint = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/ai-gateway/custom-zai/api/coding/paas/v4",
    api_key_name = "ZAI_API_KEY",
    extra_headers = gateway_authorization_headers,
    models = {
      ["glm-5.1"] = {
        model_name = "glm-5.1",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      -- ["glm-5v-turbo"] = {
      --   model_name = "glm-5v-turbo",
      --   avante = {
      --     timeout = constants.timeout.reasoning,
      --   },
      -- },
    },
  },

  unified = {
    endpoint = "https://gateway.ai.cloudflare.com/v1/fe86c3d78b514b31fdd1a74181c2c4ce/ai-gateway/compat",
    api_key_name = "CF_AIG_TOKEN",
    models = {
      -- ["claude-opus-4.6"] = {
      --   model_name = "anthropic/claude-opus-4.6",
      --   avante = {
      --     timeout = constants.timeout.reasoning,
      --   },
      -- },
      -- ["claude-sonnet-4.6"] = {
      --   model_name = "anthropic/claude-sonnet-4.6",
      --   avante = {
      --     timeout = constants.timeout.reasoning,
      --   },
      -- },
      -- ["claude-haiku-4.5"] = {
      --   model_name = "anthropic/claude-4.5-haiku",
      --   avante = {
      --     timeout = constants.timeout.normal,
      --   },
      -- },
      -- ["gemini-3.1-flash-lite"] = {
      --   model_name = "google-ai-studio/gemini-3.1-flash-lite",
      --   avante = {
      --     timeout = constants.timeout.normal,
      --   },
      -- },
      -- ["gemini-3.1-pro"] = {
      --   model_name = "google-ai-studio/gemini-3.1-pro",
      --   avante = {
      --     timeout = constants.timeout.reasoning,
      --   },
      -- },
      -- ["minimax-m2.7"] = {
      --   model_name = "minimax/m2.7",
      --   avante = {
      --     timeout = constants.timeout.reasoning,
      --   },
      -- },
      ["kimi-k2.6"] = {
        model_name = "workers-ai/@cf/moonshotai/kimi-k2.6",
        avante = {
          timeout = constants.timeout.reasoning,
        },
      },
      -- ["nemotron-3-120b-a12b"] = {
      --   model_name = "workers-ai/@cf/nvidia/nemotron-3-120b-a12b",
      --   avante = {
      --     timeout = constants.timeout.normal,
      --   },
      -- },
      -- ["glm-4.7-flash"] = {
      --   model_name = "workers-ai/@cf/zai-org/glm-4.7-flash",
      --   avante = {
      --     timeout = constants.timeout.normal,
      --   },
      -- },
    },
  },

  bai_go = {
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
