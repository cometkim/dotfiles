return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    dofile(vim.g.base46_cache .. "vim-illuminate")
    require("illuminate").configure {
      providers = { "lsp", "treesitter", "regex" },
      delay = 300,
      filetypes_denylist = {
        "gitcommit",
        "NvTerm_sp",
        "NvTerm_vsp",
        "NvimTree",
        "Telescope",
        "TelescopePrompt",
        "DressingInput",
        "OverseerForm",
        "Avante",
        "AvanteInput",
        "AvantePromptInput",
        "AvanteSelectedFiles",
      },
      modes_denylist = { "v", "i" },
    }
  end,
}
