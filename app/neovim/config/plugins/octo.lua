require("octo").setup({
	default_remote = { "upstream", "origin" },
	default_merge_method = "squash",
	picker = "telescope",
	comment_icon = "▎",
	ui = {
		use_signcolumn = false,
		use_signstatus = true,
	},
	reviews = {
		auto_show_threads = true,
		focus = "right",
	},
	pull_requests = {
		order_by = {
			field = "UPDATED_AT",
			direction = "DESC",
		},
	},
	issues = {
		order_by = {
			field = "UPDATED_AT",
			direction = "DESC",
		},
	},
})

local wk = require("which-key")

wk.add({
	{ "<leader>oo", "<cmd>Octo actions<cr>", desc = "Actions" },
	{ "<leader>os", "<cmd>Octo search<cr>", desc = "Search" },
	{ "<leader>oil", "<cmd>Octo issue list<cr>", desc = "List Issues" },
	{ "<leader>oic", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
	{ "<leader>opl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
	{ "<leader>opc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
})

-- Buffer-local keymaps for Octo buffers (PR/Issue/Review)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "octo" },
	callback = function(ev)
		local opts = { buffer = ev.buf }

		-- PR actions (when in a PR buffer)
		keymap("n", "<localleader>d", "<cmd>Octo pr diff<cr>", vim.tbl_extend("force", opts, { desc = "Diff" }))
		keymap("n", "<localleader>o", "<cmd>Octo pr checkout<cr>", vim.tbl_extend("force", opts, { desc = "Checkout" }))
		keymap(
			"n",
			"<localleader>m",
			"<cmd>Octo pr merge squash<cr>",
			vim.tbl_extend("force", opts, { desc = "Merge" })
		)
		keymap("n", "<localleader>c", "<cmd>Octo pr close<cr>", vim.tbl_extend("force", opts, { desc = "Close" }))
		keymap("n", "<localleader>R", "<cmd>Octo pr reopen<cr>", vim.tbl_extend("force", opts, { desc = "Reopen" }))
		keymap("n", "<localleader>b", "<cmd>Octo pr browser<cr>", vim.tbl_extend("force", opts, { desc = "Browser" }))
		keymap("n", "<localleader>u", "<cmd>Octo pr url<cr>", vim.tbl_extend("force", opts, { desc = "Copy URL" }))

		-- Review actions
		keymap(
			"n",
			"<localleader>rs",
			"<cmd>Octo review start<cr>",
			vim.tbl_extend("force", opts, { desc = "Start Review" })
		)
		keymap(
			"n",
			"<localleader>rr",
			"<cmd>Octo review resume<cr>",
			vim.tbl_extend("force", opts, { desc = "Resume Review" })
		)
		keymap(
			"n",
			"<localleader>rd",
			"<cmd>Octo review discard<cr>",
			vim.tbl_extend("force", opts, { desc = "Discard Review" })
		)
		keymap(
			"n",
			"<localleader>ra",
			"<cmd>Octo review submit approve<cr>",
			vim.tbl_extend("force", opts, { desc = "Approve" })
		)
		keymap(
			"n",
			"<localleader>rc",
			"<cmd>Octo review submit comment<cr>",
			vim.tbl_extend("force", opts, { desc = "Comment" })
		)
		keymap(
			"n",
			"<localleader>rx",
			"<cmd>Octo review submit request_changes<cr>",
			vim.tbl_extend("force", opts, { desc = "Request Changes" })
		)

		-- Comments
		keymap(
			"n",
			"<localleader>ca",
			"<cmd>Octo comment add<cr>",
			vim.tbl_extend("force", opts, { desc = "Add Comment" })
		)
		keymap(
			"n",
			"<localleader>cd",
			"<cmd>Octo comment delete<cr>",
			vim.tbl_extend("force", opts, { desc = "Delete Comment" })
		)

		-- Labels & Assignees
		keymap("n", "<localleader>la", "<cmd>Octo label add<cr>", vim.tbl_extend("force", opts, { desc = "Add Label" }))
		keymap(
			"n",
			"<localleader>lr",
			"<cmd>Octo label remove<cr>",
			vim.tbl_extend("force", opts, { desc = "Remove Label" })
		)
		keymap(
			"n",
			"<localleader>aa",
			"<cmd>Octo assignee add<cr>",
			vim.tbl_extend("force", opts, { desc = "Add Assignee" })
		)
		keymap(
			"n",
			"<localleader>ar",
			"<cmd>Octo assignee remove<cr>",
			vim.tbl_extend("force", opts, { desc = "Remove Assignee" })
		)

		-- Reload
		keymap("n", "<localleader>R", "<cmd>Octo reload<cr>", vim.tbl_extend("force", opts, { desc = "Reload" }))
	end,
})
