return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim",
	},
	config = function()
		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false

		require("windows").setup()

		vim.keymap.set("n", "<leader>wz", ":WindowsMaximize<CR>")
		vim.keymap.set("n", "<leader>w_", ":WindowsMaximizeVertically<CR>")
		vim.keymap.set("n", "<leader>w|", ":WindowsMaximizeHorizontally<CR>")
		vim.keymap.set("n", "<leader>w=", ":WindowsEqualize<CR>")
	end,
}
