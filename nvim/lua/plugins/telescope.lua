return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git", ".next" },
      },
    },

    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf',
        function()
          builtin.find_files({
            hidden = true,
            no_ignore = true,
          })
        end
        , { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
      vim.keymap.set("n", "<leader>i", ":Telescope import<cr>", {})
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}

