return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    dofile(vim.g.base46_cache .. "vim-illuminate")
    require("illuminate").configure {
      providers = { "lsp", "treesitter", "regex" },
      delay = 300,
      filetypes_denylist = {
        "NvimTree",
        "AvanteInput",
      },
      modes_denylist = { "v", "i" },
    }
  end,
}
