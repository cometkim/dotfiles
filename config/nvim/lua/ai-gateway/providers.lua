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
          __inherited_from = "claude",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
            max_tokens = 20480,
          },
        },
      },
      ["claude-3.5-haiku"] = {
        model_name = "claude-3-5-haiku-latest",
        avante = {
          __inherited_from = "claude",
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
            max_tokens = 8192,
          },
        },
      },
    },
  },

  -- OpenAI models
  openai = {
    endpoint = M.ai_gateway .. "/openai/v1",
    api_key_name = "OPENAI_API_KEY",
    models = {
      ["gpt-4.1"] = {
        model_name = "gpt-4.1",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
        },
      },
      ["gpt-4.1-mini"] = {
        model_name = "gpt-4.1-mini",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
        },
      },
      ["o3"] = {
        model_name = "o3",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
        },
      },
      ["o4-mini"] = {
        model_name = "o4-mini",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
        },
      },
      ["o4-mini-high"] = {
        model_name = "o4-mini-high",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
        },
      },
    },
  },

  -- Groq models
  groq = {
    endpoint = M.ai_gateway .. "/groq/v1",
    api_key_name = "GROQ_API_KEY",
    models = {
      ["qwq-32b"] = {
        model_name = "qwen-qwq-32b",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            max_completion_tokens = 32768,
            temperature = 0.6,
          },
        },
      },
      ["deepseek-r1-70b"] = {
        model_name = "deepseek-r1-distill-llama-70b",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            max_completion_tokens = 32768,
            temperature = 0.6,
          },
        },
      },
      ["llama-3.3-70b"] = {
        model_name = "llama-3.3-70b-versatile",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
          extra_request_body = {
            max_completion_tokens = 32768,
            temperature = 0.6,
          },
        },
      },
      ["llama-4-scout-17b"] = {
        model_name = "meta-llama/llama-4-scout-17b-16e-instruct",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
            max_completion_tokens = 8192,
          }
        },
      },
      ["llama-4-maverick-17b"] = {
        model_name = "meta-llama/llama-4-maverick-17b-128e-instruct",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
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
      ["gemini-2.5-flash-lite"] = {
        model_name = "gemini-2.5-flash-lite-preview-06-17",
        avante = {
          __inherited_from = "gemini",
          timeout = constants.timeout.normal,
          extra_request_body = {
            generationConfig = {
              temperature = 0.6,
            },
          },
        },
      },
      ["gemini-2.5-flash"] = {
        model_name = "gemini-2.5-flash",
        avante = {
          __inherited_from = "gemini",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            generationConfig = {
              temperature = 0.6,
            },
          },
        },
      },
      ["gemini-2.5-pro"] = {
        model_name = "gemini-2.5-pro",
        avante = {
          __inherited_from = "gemini",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            generationConfig = {
              temperature = 0.6,
            },
          },
        },
      },
      ["gemma-3n"] = {
        model_name = "gemma-3n-e4b-it",
        avante = {
          __inherited_from = "gemini",
          timeout = constants.timeout.fast,
          disable_tools = true,
          extra_request_body = {
            generationConfig = {
              temperature = 0.6,
            },
          },
        },
      },
    },
  },

  -- Cloudflare models
  --
  -- Too expensive and slow -- prefer Groq
  cloudflare = {
    endpoint = M.ai_gateway .. "/workers-ai/v1",
    api_key_name = "CLOUDFLARE_AI_API_TOKEN",
    models = {
      ["llama-3.3-70b"] = {
        model_name = "@cf/meta/llama-3.3-70b-instruct-fp8-fast",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0.6,
          },
        },
      },
      ["llama-4-scout-17b"] = {
        model_name = "@cf/meta/llama-4-scout-17b-16e-instruct",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
          },
        },
      },
      ["qwen-2.5-coder-32b"] = {
        model_name = "@cf/qwen/qwen2.5-coder-32b-instruct",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
          extra_request_body = {
            temperature = 0,
          },
        },
      },
      ["qwq-32b"] = {
        model_name = "@cf/qwen/qwq-32b",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.reasoning,
          extra_request_body = {
            temperature = 0.6,
          },
        },
      },
    },
  },

  mistral = {
    endpoint = M.ai_gateway .. "/mistral/v1",
    api_key_name = "MISTRAL_API_KEY",
    models = {
      ["codestral"] = {
        model_name = "codestral-latest",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
          extra_request_body = {
            max_tokens = 4096,
          },
        },
      },
      ["devstral"] = {
        model_name = "devstral-small-2505",
        avante = {
          __inherited_from = "openai",
          timeout = constants.timeout.normal,
          extra_request_body = {
            max_tokens = 4096,
          },
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
