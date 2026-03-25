local ignore_filetypes = { "neo-tree", "TelescopePrompt", "neo-tree-popup", "DiffviewFiles", "neogit", "trouble" }
local ignore_buftypes = { "nofile", "prompt", "popup", "quickfix", "help" }

local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
			vim.w.focus_disable = true
		else
			vim.w.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for BufType",
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
			vim.b.focus_disable = true
		else
			vim.b.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for FileType",
})

require("focus").setup({
	enable = true,
	commands = true,
	autoresize = { enable = true, width = 0, height = 0, minwidth = 0, minheight = 0 },
	ui = {
		number = false,
		relativenumber = false,
		hybridnumber = false,
		cursorline = false,
		cursorcolumn = false,
		signcolumn = false,
		winhighlight = false,
	},
})

local wk = require("which-key")

wk.add({
	-- Window keymaps (Focus)
	{ "<leader>wh", "<cmd>FocusSplitLeft<cr>", desc = "Split Left" },
	{ "<leader>wj", "<cmd>FocusSplitDown<cr>", desc = "Split Down" },
	{ "<leader>wk", "<cmd>FocusSplitUp<cr>", desc = "Split Up" },
	{ "<leader>wl", "<cmd>FocusSplitRight<cr>", desc = "Split Right" },
	{ "<leader>wm", "<cmd>FocusMaximise<cr>", desc = "Maximise" },
	{ "<leader>we", "<cmd>FocusEqualise<cr>", desc = "Equalise" },
	{ "<leader>wn", "<cmd>FocusSplitNicely<cr>", desc = "Split Nicely" },
	{ "<leader>wc", "<cmd>FocusSplitCycle<cr>", desc = "Cycle Split" },
	{ "<leader>wt", "<cmd>FocusToggle<cr>", desc = "Toggle Focus" },
	{ "<leader>wo", "<cmd>only<cr>", desc = "Only" },
	{ "<leader>wq", "<cmd>close<cr>", desc = "Close" },
})
