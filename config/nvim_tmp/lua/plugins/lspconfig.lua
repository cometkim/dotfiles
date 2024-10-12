return {
  "neovim/nvim-lspconfig",
  config = function()
    local nvlsp = require "nvchad.configs.lspconfig"
    local lspconfig = require "lspconfig"
    local schemastore = require "schemastore"

    nvlsp.defaults()

    -- lsps with default config
    local servers = { "html", "cssls", "ts_ls", "lua_ls", "biome" }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }
    end

    -- JSON
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

    -- YAML
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
  end,
}
