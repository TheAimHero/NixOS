require("diffview").setup({
	enhanced_diff_hl = true,
	use_icons = true,
	view = {
		default = { layout = "diff2_horizontal" },
		merge_tool = { layout = "diff3_horizontal" },
		file_history = { layout = "diff2_horizontal" },
	},
	keymaps = {
		view = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } } },
		file_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } } },
		file_history_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } } },
	},
})

local keymap = vim.keymap.set

keymap("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Diffview" })
keymap("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History" })
keymap("n", "<leader>gF", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch History" })
