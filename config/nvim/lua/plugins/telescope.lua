-- Already configured by NvChad
return {
  "nvim-telescope/telescope.nvim",
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "telescope")
    require("telescope").setup(opts)
  end
}
