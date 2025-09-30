local schemastore = require "schemastore"

---@type vim.lsp.Config
return {
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
