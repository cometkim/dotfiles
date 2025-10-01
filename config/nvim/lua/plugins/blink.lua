return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
  },
  opts = {
    enabled = function ()
      local disabled_filetypes = {
        "TelescopePrompt",
        "NvimTree",
        "DressingInput",
      }
      return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
    end,
    sources = {
      default = {
        "avante",
        "lazydev",
        "lsp",
        "path",
        "buffer",
        "snippets",
        "minuet",
      },
      providers = {
        avante = {
          name = "Avante",
          module = "blink-cmp-avante",
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
        minuet = {
          name = "minuet",
          module = "minuet.blink",
          async = true,
          timeout_ms = 2000,
          score_offset = -1,
        },
      },
    },
    completion = {
      trigger = {
        prefetch_on_insert = false,
      },
    },
  },
}
