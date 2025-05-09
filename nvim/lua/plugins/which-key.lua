return {
  "folke/which-key.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "Buffers", icon = "" },
      { "<leader>c", group = "Code", icon = "⌨" },
      { "<leader>d", group = "Debugger", icon = "" },
      { "<leader>f", group = "Files", icon = "" },
      { "<leader>g", group = "GoTo", icon = "" },
      { "<leader>h", group = "Help", icon = "󰋖" },
      { "<leader>q", group = "Quit", icon = "⏻" },
      { "<leader>t", group = "Test", icon = "" },
      { "<leader>w", group = "Windows", icon = "" },
      { "<leader>p", group = "Project", icon = "" },
    }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Local Keymaps",
    },
  },
}
