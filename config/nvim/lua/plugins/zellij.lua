return {
  'fresh2dev/zellij.vim',
  tag = '0.4.0',
  event = "VeryLazy",
  init = function()
    vim.g.zelli_navigator_move_focus_or_tab = 1
    vim.g.zellij_navigator_no_default_mappings = 1
  end,
  keys = {
    { mode = { "n" }, "<leader>zjt", "<CMD>ZellijNewTab<CR>",        silent = true, desc = "Zellij: Open new tab" },
    { mode = { "n" }, "<leader>zjf", "<CMD>ZellijNewPane<CR>",       silent = true, desc = "Zellij: Open floating pane" },
    { mode = { "n" }, "<leader>zjo", "<CMD>ZellijNewPaneSplit<CR>",  silent = true, desc = "Zellij: Open pane below" },
    { mode = { "n" }, "<leader>zjv", "<CMD>ZellijNewPaneVSplit<CR>", silent = true, desc = "Zellij: Open pane to the right" },
    {
      mode = { "n" },
      "<leader>zjrf",
      function()
        vim.cmd('ZellijNewPane ' .. vim.fn.input('Command: '))
      end,
      silent = true,
      desc = "Zellij: Run command in floating pane"
    },
    {
      mode = { "n" },
      "<leader>zjro",
      function()
        vim.cmd('ZellijNewPaneSplit ' .. vim.fn.input('Command: '))
      end,
      silent = true,
      desc = "Zellij: Run command in pane below"
    },
    {
      mode = { "n" },
      "<leader>zjrv",
      function()
        vim.cmd('ZellijNewPaneVSplit ' .. vim.fn.input('Command: '))
      end,
      silent = true,
      desc = "Zellij: Run command in pane to the right"
    },
  },
}
