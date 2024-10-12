return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  opts = {},
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<leader>m",
      "<cmd>MCstart<cr>",
      desc = "Multi cursors",
    },
    {
      mode = { "v", "n" },
      "<c-n>",
      "<cmd>MCstart<cr>",
      desc = "Multi cursors",
    },
  },
}
