dofile(vim.g.base46_cache .. "treesitter")

local ensure_installed = {
  "astro",
  "bash",
  "capnp",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "ebnf",
  "editorconfig",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "glsl",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "graphql",
  "hcl",
  "html",
  "hurl",
  "ini",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "kdl",
  "kotlin",
  "lua",
  "menhir",
  "nginx",
  "ocaml",
  "ocaml_interface",
  "ocamllex",
  "pem",
  "prisma",
  "proto",
  "python",
  "query",     -- Tree-Sitter query language
  "rescript",
  "robots_txt",
  "ron",
  "ruby",
  "rust",
  "sql",
  "starlark",
  "svelte",
  "swift",
  "textproto",
  "thrift",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "wgsl",
  "wit",
  "xml",
  "yaml",
  "zig",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require "nvim-treesitter"

    local already_installed = ts.get_installed()
    local parsers_to_install = vim.iter(ensure_installed)
    :filter(function(parser)
      return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()

    ts.install(parsers_to_install)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
