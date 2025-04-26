return {
  "fedepujol/move.nvim",
  config = function()
    require("move").setup {}
  end,
  keys = {
    { mode = { "n" }, "<A-j>", "<CMD>MoveLine(1)<CR>",    silent = true },
    { mode = { "n" }, "<A-k>", "<CMD>MoveLine(-1)<CR>",   silent = true },
    -- { mode = { "n" }, "<A-h>", "<CMD>MoveHChar(-1)<CR>", silent = true },
    -- { mode = { "n" }, "<A-l>", "<CMD>MoveHChar(1)<CR>", silent = true },
    { mode = { "v" }, "<A-j>", "<CMD>MoveBlock(1)<CR>",   silent = true },
    { mode = { "v" }, "<A-k>", "<CMD>MoveBlock(-1)<CR>",  silent = true },
    { mode = { "v" }, "<A-h>", "<CMD>MoveHBlock(-1)<CR>", silent = true },
    { mode = { "v" }, "<A-l>", "<CMD>MoveHBlock(1)<CR>",  silent = true },
  },
}
