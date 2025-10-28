return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
	},
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dapui").setup()
    require("dap-python").setup("python3")
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
    })

    -- Mason DAP for automatic adapter installation
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb", "delve" },
      automatic_installation = true,
      handlers = {},
    })

    -- codelldb adapter for C/C++/Rust
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- C++ Debug Configuration
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        args = {},
      },
    }

    -- C uses same config as C++
    dap.configurations.c = dap.configurations.cpp

    -- Go Debug Configuration (Delve)
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }

    -- Load VSCode launch.json if it exists
    local vscode_ok, vscode = pcall(require, "dap.ext.vscode")
    if vscode_ok then
      vscode.load_launchjs(nil, { codelldb = { "c", "cpp" }, delve = { "go" } })
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Debugging keymaps
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue/Start debugging" })
    vim.keymap.set("n", "<Leader>dso", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<Leader>dsi", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<Leader>dsx", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run last" })
    vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "Terminate debugging" })
  end,
}
