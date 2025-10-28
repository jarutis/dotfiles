-- Format on save and linters
return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	keys = {
		{ "<leader>cf", vim.lsp.buf.format, desc = "Format buffer" },
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- list of formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"checkmake",
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
				"shfmt",
				"ruff",
				"clang-format", -- C/C++ formatter
				"gofumpt", -- Go formatter (stricter than gofmt)
				"goimports-reviser", -- Go imports formatter
				"golangci-lint", -- Go linter
			},
			-- auto-install configured formatters & linters (with null-ls)
			automatic_installation = true,
		})

		local sources = {
			diagnostics.checkmake,
			formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.terraform_fmt,
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
			formatting.clang_format.with({
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				extra_args = { "--style=file", "--fallback-style=llvm" },
			}),
			-- Go formatters and linters
			formatting.gofumpt,
			formatting.goimports_reviser,
			diagnostics.golangci_lint,
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
		})
	end,
}
