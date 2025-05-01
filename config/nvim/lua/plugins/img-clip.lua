return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- settings recommended avante.nvim
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    },
  },
  keys = {
    { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
