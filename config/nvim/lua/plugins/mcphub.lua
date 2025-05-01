return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  cmd = "MCPHub",  -- lazy load
  build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
  -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  keys = {
    {
      mode = { "n" },
      "<leader>amcp",
      "<CMD>MCPHub<CR>",
      desc = "Open MCPHub",
    },
  },
  config = function()
    require("mcphub").setup {
      use_bundled_binary = true,
      extensions = {
        avante = {
          make_slash_commands = false,
        },
      },
    }
  end,
}
