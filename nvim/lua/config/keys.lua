vim.keymap.set("n", "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr><esc>", { desc = "Split window verticaly" })
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr><esc>", { desc = "Split window horizonaly" })
vim.keymap.set("n", "<leader>wq", "<cmd>q<cr><esc>", { desc = "Close pane" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr><esc>", { desc = "Quit" })

-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "System yank" })
vim.keymap.set("n", "<leader>]", [["+p]], { desc = "System paste" })

