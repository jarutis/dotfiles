-- CMake integration for C++ projects
return {
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			cmake_command = "cmake",
			cmake_build_directory = "build",
			cmake_build_directory_prefix = "", -- when cmake_build_directory is "", this option will be activated
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_build_options = {},
			cmake_console_size = 10, -- cmake output window height
			cmake_show_console = "always", -- "always", "only_on_error"
			cmake_dap_configuration = {
				name = "cpp",
				type = "codelldb",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = false,
				console = "integratedTerminal",
			},
			cmake_executor = {
				name = "quickfix",
				opts = {},
				default_opts = {
					quickfix = {
						show = "always", -- "always", "only_on_error"
						position = "belowright",
						size = 10,
					},
				},
			},
			cmake_runner = {
				name = "terminal",
				opts = {},
				default_opts = {
					terminal = {
						name = "Main Terminal",
						prefix_name = "[CMakeTools]: ",
						split_direction = "horizontal",
						split_size = 11,
					},
				},
			},
			cmake_notifications = {
				enabled = true,
				spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
			},
			cmake_virtual_text_support = true,
		},
		config = function(_, opts)
			require("cmake-tools").setup(opts)

			-- CMake keymaps
			vim.keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
			vim.keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
			vim.keymap.set("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
			vim.keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
			vim.keymap.set("n", "<leader>cs", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
			vim.keymap.set("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Build Target" })
			vim.keymap.set("n", "<leader>cc", "<cmd>CMakeClose<cr>", { desc = "CMake Close" })
			vim.keymap.set("n", "<leader>cC", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
		end,
	},
}
