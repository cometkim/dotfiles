local map = vim.keymap.set

return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    dofile(vim.g.base46_cache .. "nvimtree")

    local nvtree = require "nvim-tree"
    local api = require "nvim-tree.api"

    local function custom_on_attach(bufnr)
      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      api.config.mappings.default_on_attach(bufnr)
      map("n", "+", api.tree.change_root_to_node, opts "CD")
      map("n", "?", api.tree.toggle_help, opts "Help")
      map("n", "l", function()
        local node = api.tree.get_node_under_cursor()
        if not node then
          return
        end
        if not (node.type == "directory" and node.open) then
          api.node.open.edit()
          -- elseif node.type == "directory" then
          --   local key = vim.api.nvim_replace_termcodes("<Down>", true, false, true)
          --   vim.api.nvim_feedkeys(key, "n", false)
        end
      end, opts "Open")
      map("n", "h", function()
        local node = api.tree.get_node_under_cursor()
        if not node then
          return
        end
        if node.type == "directory" and node.open then
          api.node.open.edit()
        else
          api.node.navigate.parent_close()
        end
      end, opts "Close Directory")
    end

    -- Automatically open file upon creation
    api.events.subscribe(api.events.Event.FileCreated, function(file)
      vim.cmd("edit " .. file.fname)
    end)

    nvtree.setup {
      on_attach = custom_on_attach,
      update_focused_file = {
        enable = true,
      },
      filters = {
        dotfiles = false,
      },
    }
  end,
  keys = {
    {
      mode = "n",
      "<leader>e",
      "<cmd>NvimTreeToggle<cr>",
      desc = "Toggle NvimTree",
    },
  },
}
