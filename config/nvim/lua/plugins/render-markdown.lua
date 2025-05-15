return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  ft = { "markdown", "Avante" },
  opts = {
    file_types = { "markdown", "Avante" },
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "render-markdown")
    require("render-markdown").setup(opts)
  end,
}
