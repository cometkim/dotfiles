require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- Should be remapped without Lazy
map("n", "<C-j>", "<CMD>ZellijNavigateDown<CR>", { silent = true, desc = "Zellij: Move to down pane" })
map("n", "<C-k>", "<CMD>ZellijNavigateUp<CR>", { silent = true, desc = "Zellij: Move to up pane" })
map("n", "<C-h>", "<CMD>ZellijNavigateLeft<CR>", { silent = true, desc = "Zellij: Move to left pane" })
map("n", "<C-l>", "<CMD>ZellijNavigateRight<CR>", { silent = true, desc = "Zellij: Move to right pane" })

-- Comments
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true })
map("n", "<leader>/", "<CMD>Commentless<CR>", { desc = "Toggle Comments", remap = true })
map("v", "<leader>/", "<CMD>Commentless<CR>", { desc = "Toggle Comments", remap = true })

map("t", "<Esc><Esc><Esc>", "<C-\\><C-n>", { silent = true })
