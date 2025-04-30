return {
  "soemre/commentless.nvim",
  cmd = "Commentless",
  config = function()
    require("commentless").setup {}
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
