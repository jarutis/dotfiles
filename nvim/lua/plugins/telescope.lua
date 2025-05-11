return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jonarrien/telescope-cmdline.nvim",
		},
		keys = {
			{ "<leader>x", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
			{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files in project" },
			{ "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
			{ "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help" },
		},

		opts = {
			defaults = {
				file_ignore_patterns = { "node_modules", ".git", ".next" },
			},
		},
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
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
