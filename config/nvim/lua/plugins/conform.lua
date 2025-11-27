return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = {
    "ConformInfo",
    "AutoFormatToogle",
    "AutoFormatEnable",
    "AutoFormatDisable",
  },
  keys = {
    {
      "<leader>fmf",
      function()
        require("conform").format({
          async = true,
          lsp_format = "first"
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<leader>fma",
      "<CMD>AutoFormatToggle<CR>",
      mode = "",
      desc = "Toggle auto-format",
    },
  },
  config = function()
    vim.g.enable_autoformat = false

    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylelua" },
        javascript = { "biome-check", lsp_format = "prefer" },
        javascriptreact = { "biome-check", lsp_format = "prefer" },
        typescript = { "biome-check", lsp_format = "prefer" },
        typescriptreact = { "biome-check", lsp_format = "prefer" },
        json = { "biome", lsp_format = "prefer" },
        css = { "biome", lsp_format = "prefer" },
        rust = { "rustfmt" },
      },
      format_on_save = function(bufnr)
        if not vim.g.enable_autoformat then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end

        return {
          timeout_ms = 500,
          lsp_format = "prefer",
        }
      end,
    }

    vim.api.nvim_create_user_command("AutoFormatEnable", function()
      vim.g.enable_autoformat = true
    end, {
      desc = "Enable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("AutoFormatDisable", function()
      vim.g.enable_autoformat = false
    end, {
      desc = "Disable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("AutoFormatToggle", function()
      vim.g.enable_autoformat = not vim.g.enable_autoformat
    end, {
      desc = "Toggle autoformat-on-save",
    })
  end
}
