return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ignore_install = { "ipkg", "org" },
        ensure_installed = {
          "c",
          "cpp",
          "python",
          "lua",
          "vim",
          "astro",
          "html",
          "css",
          "comment",
          "vimdoc",
          "javascript",
          "typescript",
          "tsx",
          "dockerfile",
          "terraform",
          "rust",
          "zig",
          "go",
          "gomod",
          "gosum",
          "gowork",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
}
