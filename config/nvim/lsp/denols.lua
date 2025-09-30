local utils = require "utils"

---@type vim.lsp.Config
return {
  root_dir = function(_, on_dir)
    if utils.is_deno() then
      on_dir(vim.fn.getcwd())
    end
  end,
}
