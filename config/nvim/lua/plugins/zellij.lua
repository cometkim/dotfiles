return {
  'fresh2dev/zellij.vim',
  tag = '0.4.0',
  lazy = false,
  init = function()
    vim.g.zelli_navigator_move_focus_or_tab = 1
    vim.g.zellij_navigator_no_default_mappings = 1
  end,
}
