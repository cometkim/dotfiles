return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "sindrets/diffview.nvim",
  },
  config = function()
    dofile(vim.g.base46_cache .. "git")
    dofile(vim.g.base46_cache .. "neogit")
    require("neogit").setup {}
  end,
  keys = {
    {
      mode = { "n" },
      "<Leader>gg",
      "<cmd>Neogit<cr>",
      desc = "Neogit",
    },
  },
}
