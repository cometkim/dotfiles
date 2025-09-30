local schemastore = require "schemastore"

---@type vim.lsp.Config
return {
  settings = {
    json = {
      validate = { enable = true },
      schemas = schemastore.json.schemas(),
    },
  },
}
