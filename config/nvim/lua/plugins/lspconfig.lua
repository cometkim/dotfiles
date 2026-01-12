return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
  },
  config = function()
    local nvlsp = require "nvchad.configs.lspconfig"

    nvlsp.defaults()

    vim.lsp.config("*", {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    })

    vim.lsp.enable {
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      "taplo",
      "ts_ls",
      "tsgo",
      "tailwindcss",
      "denols",
      "biome",
      "ocamllsp",
      "rust_analyzer",
      "rescriptls",
    }
  end,
}
