return {
  "Isrothy/neominimap.nvim",
  version = "v3.16.0",
  lazy = false,
  keys = {
    -- Global Minimap Controls
    { "<leader>mm", "<cmd>Neominimap Toggle<cr>",  desc = "Toggle global minimap" },
    { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 24

    vim.g.neominimap = {
      click = {
        enabled = true,
      },

      float = {
        minimap_width = 16,
      }
    }

    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
      callback = function()
        local buf_lines = vim.api.nvim_buf_line_count(0)
        local win_height = vim.api.nvim_win_get_height(0)
        if buf_lines > win_height then
          vim.cmd("Neominimap Enable")
        else
          vim.cmd("Neominimap Disable")
        end
      end,
    })
  end,
}
