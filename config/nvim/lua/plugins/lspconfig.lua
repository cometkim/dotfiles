return {
  "neovim/nvim-lspconfig",
  config = function()
    local nvlsp = require "nvchad.configs.lspconfig"
    local lspconfig = require "lspconfig"
    local schemastore = require "schemastore"

    nvlsp.defaults()

    local servers = {
      html = {},
      cssls = {},
      jsonls = {
        json = {
          validate = { enable = true },
          schemas = schemastore.json.schemas(),
        },
      },
      yamlls = {
        yaml = {
          validate = true,
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = schemastore.yaml.schemas(),
        },
      },
      taplo = {}, -- TOML
      ts_ls = {},
      lua_ls = {},
      biome = {},
      ocamllsp = {
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
      rust_analyzer = {
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

    local on_attach = function(client, bufnr)
      nvlsp.on_attach(client, bufnr)

      -- handled via conform.nvim
      -- if client.server_capabilities.documentFormattingProvider then
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     buffer = bufnr,
      --     callback = function()
      --       vim.lsp.buf.format { async = false }
      --     end,
      --   })
      -- end

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
          buffer = bufnr,
          callback = function()
            vim.lsp.codelens.refresh()
          end,
        })
      end
    end

    for lsp, settings in pairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
        settings = settings,
      }
    end
  end,
}
