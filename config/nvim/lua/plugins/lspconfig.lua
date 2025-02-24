return {
  "neovim/nvim-lspconfig",
  config = function()
    local nvlsp = require "nvchad.configs.lspconfig"
    local lspconfig = require "lspconfig"
    local schemastore = require "schemastore"

    nvlsp.defaults()

    lspconfig.html.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }

    lspconfig.cssls.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }

    lspconfig.jsonls.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        json = {
          validate = { enable = true },
          schemas = schemastore.json.schemas(),
        },
      },
    }

    lspconfig.yamlls.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        yaml = {
          validate = true,
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = schemastore.yaml.schemas(),
        },
      },
    }

    -- TOML
    lspconfig.taplo.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }

    -- TypeScript
    lspconfig.ts_ls.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }

    -- Lua
    lspconfig.lua_ls.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }

    -- https://biomejs.dev
    lspconfig.biome.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }

    lspconfig.ocamllsp.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        ocamllsp = {
          extendedHover = {
            enable = true,
          },
          duneDiagnostics = {
            enable = true,
          },
          inlayHints = {
            enable = true,
            hintLetBindings = true,
            hintPatternVariables = true,
          },
          codelens = {
            enable = true,
          },
        },
      },
    }

    lspconfig.rust_analyzer.setup = {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    }
  end,
}
