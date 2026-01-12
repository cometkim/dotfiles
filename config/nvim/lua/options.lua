require "nvchad.options"

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.autoread = true

local ft = vim.filetype
ft.add {
  filename = {
    ["Brewfile"] = "ruby",
  },
}
ft.add {
  pattern = {
    [".*/cometkim/dotfiles/gitconfig"] = "gitconfig",
  },
}
ft.add {
  filename = {
    ["zshrc"] = "zsh",
    ["\\.zshrc"] = "zsh",
    ["zprofile"] = "zsh",
    ["\\.zprofile"] = "zsh",
  },
  pattern = {
    ["zshrc-.*"] = "zsh",
    ["\\.zshrc-.*"] = "zsh",
  },
}
