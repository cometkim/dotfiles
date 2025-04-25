---@module "neominimap.config.meta"
return {
  "Isrothy/neominimap.nvim",
  version = "v3.12.0",
  lazy = false,
  keys = {
    -- Global Minimap Controls
    { "<leader>mm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
    -- { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    -- vim.opt.wrap = false
    -- vim.opt.sidescrolloff = 36 -- Set a large value

    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
    }
  end,
}
