-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",
  integrations = {
    "avante",
    "neogit",
    "render-markdown",
    "telescope",
    "treesitter",
    "semantic_tokens",
    "vim-illuminate"
  },
}

return M
