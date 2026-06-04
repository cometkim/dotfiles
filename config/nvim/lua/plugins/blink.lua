local utils = require("utils")

return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
  },
  opts = {
    enabled = function()
      local disabled_filetypes = {
        "TelescopePrompt",
        "NvimTree",
        "DressingInput",
      }
      return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
    end,
    sources = {
      default = (function()
        local sources = {
          "lazydev",
          "lsp",
          "path",
          "buffer",
          "snippets",
        }
        if not utils.is_ai_denied() then
          table.insert(sources, 0, "avante")
          table.insert(sources, 0, "minuet")
        end
        return sources
      end)(),
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
