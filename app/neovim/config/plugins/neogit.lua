require("neogit").setup({
	graph_style = "kitty",
	kind = "tab",
	commit_select_view = { kind = "tab" },
	commit_view = { kind = "vsplit" },
	log_view = { kind = "tab" },
	rebase_editor = { kind = "auto" },
	reflog_view = { kind = "tab" },
	merge_editor = { kind = "auto" },
	preview_buffer = { kind = "split" },
	popup = { kind = "split" },
	signs = {
		hunk = { "", "" },
		item = { "", "" },
		section = { "", "" },
	},
	integrations = {
		diffview = true,
		telescope = true,
	},
})

local keymap = vim.keymap.set

-- Neogit keymaps
keymap("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
keymap("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Neogit Commit" })
keymap("n", "<leader>gP", "<cmd>Neogit push<cr>", { desc = "Neogit Push" })
keymap("n", "<leader>gp", "<cmd>Neogit pull<cr>", { desc = "Neogit Pull" })
keymap("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "Neogit Log" })
