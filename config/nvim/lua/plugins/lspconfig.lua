return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
  },
  config = function()
    local nvlsp = require "nvchad.configs.lspconfig"
    local schemastore = require "schemastore"
    local utils = require "utils"

    nvlsp.defaults()

    vim.lsp.config("*", {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          validate = { enable = true },
          schemas = schemastore.json.schemas(),
        },
      },
    })

    vim.lsp.config("yamlls", {
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
    })

    vim.lsp.config("ts_ls", {
      root_dir = function(_, on_dir)
        if not utils.is_deno() then
          on_dir(vim.fn.getcwd())
        end
      end,
    })

    vim.lsp.config("denols", {
      root_dir = function(_, on_dir)
        if utils.is_deno() then
          on_dir(vim.fn.getcwd())
        end
      end,
    })

    vim.lsp.config("ocamllsp", {
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
    })

    vim.lsp.config("rust_analyzer", {
      on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
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
          check = {
            command = "clippy",
          },
        },
      }
    })

    vim.lsp.enable {
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      "taplo",
      "ts_ls",
      "denols",
      "biome",
      "ocamllsp",
      "rust_analyzer",
      "rescriptls",
    }
  end,
}
