local utils = {}

local uv = vim.uv or vim.loop

---Check whether file exists
---@param ... string
---@return boolean
function utils.file_exists(...)
  for _, filepath in ipairs { ... } do
    filepath = table.concat({ vim.fn.getcwd(), filepath }, "/")

    if uv.fs_stat(filepath) ~= nil then
      return true
    end
  end

  return false
end

---@return boolean
function utils.is_deno()
  return utils.file_exists("deno.json", "deno.jsonc", "deno.lock")
end

return utils
