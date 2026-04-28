return {
  "carldaws/miser.nvim",
  event = "VeryLazy",
  config = function()
    require("miser").setup {
      auto_install = false,
      auto_format = false,
      task_runner = function(cmd)
        require("nvchad.term").new { cmd = cmd, pos = "sp", id = "miser." .. cmd }
      end,
      registry = {
      },
    }
  end,
}
