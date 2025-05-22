return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    table.insert(opts.sources, { name = "minuet" })
    opts.performance = {
      fetching_timeout = 2000
    }
  end,
}
