return {
  "RRethy/vim-illuminate",
  config = function()
    dofile(vim.g.base46_cache .. "vim-illuminate")
    require("illuminate").configure {}
  end,
}
