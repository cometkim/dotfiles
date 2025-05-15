return {
  "RRethy/vim-illuminate",
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "vim-illuminate")
    require("illuminate").configure(opts)
  end,
}
