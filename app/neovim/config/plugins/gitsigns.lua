require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	signs_staged = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
	},
	signcolumn = true,
	numhl = true,
	linehl = false,
	word_diff = false,
	watch_gitdir = {
		follow_files = true,
	},
	auto_attach = true,
	attach_to_untracked = true,
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 300,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	max_file_length = 40000,
	preview_config = {
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local keymap = vim.keymap.set

		-- Navigation
		keymap("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { buffer = bufnr, desc = "Next Hunk" })

		keymap("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { buffer = bufnr, desc = "Prev Hunk" })

		keymap("n", "]H", function()
			gitsigns.nav_hunk("last")
		end, { buffer = bufnr, desc = "Last Hunk" })

		keymap("n", "[H", function()
			gitsigns.nav_hunk("first")
		end, { buffer = bufnr, desc = "First Hunk" })

		-- Hunk actions (<leader>gh*)
		keymap("n", "<leader>ghs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
		keymap("n", "<leader>ghr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
		keymap("v", "<leader>ghs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { buffer = bufnr, desc = "Stage Hunk" })
		keymap("v", "<leader>ghr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { buffer = bufnr, desc = "Reset Hunk" })
		keymap("n", "<leader>ghS", gitsigns.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
		keymap("n", "<leader>ghu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
		keymap("n", "<leader>ghR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Reset Buffer" })
		keymap("n", "<leader>ghp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })

		-- Blame
		keymap("n", "<leader>gb", function()
			gitsigns.blame_line({ full = true })
		end, { buffer = bufnr, desc = "Blame Line" })
		keymap("n", "<leader>gB", gitsigns.blame, { buffer = bufnr, desc = "Blame Buffer" })

		-- Toggles
		keymap("n", "\\gb", gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle Line Blame" })
		keymap("n", "\\gd", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Toggle Deleted" })

		-- Text object
		keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select Hunk" })
	end,
})
