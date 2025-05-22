return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    max_time = 5000,
    max_count = 25,
    disable_mouse = false,
    restriction_mode = "hint",
  },
}
