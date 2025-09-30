return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      {
        path = "${3rd}/luv/library",
        words = { "vim%.uv" },
      },
      "LazyVim",
      "ui/nvchad_types",
    },
    -- disable when a .luarc.json file is found
    enabled = function(root_dir)
      return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    end,
  },
}
