return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "render-markdown")
    require("render-markdown").setup(opts)
  end,
}
