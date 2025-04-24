require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

map('n', '<C-h>', ':ZellijNavigateLeft<CR>', { silent = true, desc = 'Zellij: Move to left pane' })
map('n', '<C-j>', ':ZellijNavigateDown<CR>', { silent = true, desc = 'Zellij: Move to down pane' })
map('n', '<C-k>', ':ZellijNavigateUp<CR>', { silent = true, desc = 'Zellij: Move to up pane' })
map('n', '<C-l>', ':ZellijNavigateRight<CR>', { silent = true, desc = 'Zellij: Move to right pane' })

map('n', '<leader>zjf', ':ZellijNewPane<CR>', { silent = true, desc = 'Zellij: Open floating pane' })
map('n', '<leader>zjo', ':ZellijNewPaneSplit<CR>', { silent = true, desc = 'Zellij: Open pane below' })
map('n', '<leader>zjv', ':ZellijNewPaneVSplit<CR>', { silent = true, desc = 'Zellij: Open pane to the right' })
map('n', '<leader>zjrf', function()
  vim.cmd('ZellijNewPane ' .. vim.fn.input('Command: '))
end, { silent = true, desc = 'Zellij: Run command in floating pane' })
map('n', '<leader>zjro', function()
  vim.cmd('ZellijNewPaneSplit ' .. vim.fn.input('Command: '))
end, { silent = true, desc = 'Zellij: Run command in pane below' })
map('n', '<leader>zjrv', function()
  vim.cmd('ZellijNewPaneVSplit ' .. vim.fn.input('Command: '))
end, { silent = true, desc = 'Zellij: Run command in pane to the right' })
