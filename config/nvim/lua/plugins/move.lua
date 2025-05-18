return {
  "fedepujol/move.nvim",
  opts = {
    line = {
      enable = true,
      indent = false,
    },
    block = {
      enable = true,
      indent = false,
    },
  },
  keys = {
    { mode = { "n" }, "<A-j>", ":MoveLine(1)<CR>",   silent = true, noremap = true },
    { mode = { "n" }, "<A-k>", ":MoveLine(-1)<CR>",  silent = true, noremap = true },
    { mode = { "v" }, "<A-j>", ":MoveBlock(1)<CR>",  silent = true, noremap = true },
    { mode = { "v" }, "<A-k>", ":MoveBlock(-1)<CR>", silent = true, noremap = true },
  },
}
