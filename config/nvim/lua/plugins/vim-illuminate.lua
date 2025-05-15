return {
  "RRethy/vim-illuminate",
  lazy = false,
  config = function()
    dofile(vim.g.base46_cache .. "vim-illuminate")
    require("illuminate").configure {
      providers = { "lsp", "treesitter", "regex" },
      delay = 300,
    }
  end,
}
