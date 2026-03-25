local wk = require("which-key")

wk.setup({
	preset = "modern",
	delay = 300,
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
		mappings = true,
		rules = {},
		colors = true,
	},
	win = { border = "single", padding = { 1, 2 }, title = true, title_pos = "center" },
	layout = { width = { min = 20 }, spacing = 3 },
	show_help = true,
	show_keys = true,
	triggers = {
		{ "<auto>", mode = "nxso" },
	},
})

-- Register group names
wk.add({
	{ "<leader>g", group = "Git" },
	{ "<leader>gh", group = "Hunks" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>u", group = "Utils" },
	{ "<leader>f", group = "Find" },
	{ "<leader>b", group = "Buffer" },
	{ "<leader>w", group = "Window" },
	{ "<leader>h", group = "Harpoon" },
	{ "<leader>o", group = "Octo" },
	{ "<leader>oi", group = "Issues" },
	{ "<leader>op", group = "PRs" },
	{ "\\", group = "Toggle" },
	{ "\\g", group = "Git Toggle" },
	{ "[", group = "Prev" },
	{ "]", group = "Next" },
	{ "g", group = "Goto" },
	{ "z", group = "Fold" },
})
