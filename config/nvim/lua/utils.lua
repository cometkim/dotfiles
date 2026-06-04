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

---Returns true if current working directory is in the denylist for AI features.
---This is used to disable AI plugins (avante, minuet, etc.) for company projects.
---Denylist entries are matched as substrings in the cwd path.
---e.g. company projects live under $WORKDIR/src/github.com/karrot-emu/
---@return boolean
function utils.is_ai_denied()
  local cwd = vim.fn.getcwd()
  if not cwd or cwd == "" then
    cwd = (vim.uv and vim.uv.cwd()) or ""
  end

  -- denylist with ("karrot-emu")
  local denylist = { "karrot-emu" }

  for _, entry in ipairs(denylist) do
    if cwd:find(entry, 1, true) then
      return true
    end
  end
  return false
end

return utils
