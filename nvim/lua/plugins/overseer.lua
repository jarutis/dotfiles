-- Task runner for VSCode tasks.json integration
return {
	"stevearc/overseer.nvim",
	opts = {
		task_list = {
			direction = "bottom",
			min_height = 25,
			max_height = 25,
			default_detail = 1,
		},
		templates = { "builtin", "user.cpp_build" },
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		-- Automatically load tasks.json from .vscode folder
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				local vscode_tasks = vim.fn.getcwd() .. "/.vscode/tasks.json"
				if vim.fn.filereadable(vscode_tasks) == 1 then
					require("overseer").load_task_bundle(vscode_tasks, { ignore_missing = true })
				end
			end,
		})

		-- Keymaps for overseer
		vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run task" })
		vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Toggle task list" })
		vim.keymap.set("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
		vim.keymap.set("n", "<leader>oi", "<cmd>OverseerInfo<cr>", { desc = "Overseer info" })
	end,
}
