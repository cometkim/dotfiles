-- Already configured by NvChad
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jonarrien/telescope-cmdline.nvim',
  },
  keys = {
    { "<leader><leader>", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
  },
  opts = {
    extensions = {
      cmdline = {
        overseer = {
          enabled = true,
        },
      },
    },
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "telescope")
    require("telescope").setup(opts)
    require("telescope").load_extension("cmdline")
  end
}
