return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require "conform"

    require("conform").setup({
      format_on_save = function(bufnr)
        if vim.g.enable_autoformat or vim.b[bufnr].enable_autoformat then
          return {
            timeout_ms = 500,
            lsp_format = "prefer"
          }
        end
      end,
    })

    vim.api.nvim_create_user_command("AutoFormatEnable", function()
      vim.b.enable_autoformat = true
      vim.g.enable_autoformat = true
    end, {
      desc = "Enable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("AutoFormatDisable", function(args)
      if args.bang then
        vim.b.enable_autoformat = false
      else
        vim.g.enable_autoformat = false
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatRange", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format({
        lsp_format = "prefer",
        range = range
      })
    end, { range = true })

    vim.api.nvim_create_user_command("Format", function()
      conform.format({
        lsp_format = "prefer",
      })
    end, { range = true })
  end
}
