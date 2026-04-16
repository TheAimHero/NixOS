require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 100,
		keymap = {
			accept = "<C-f>",
			accept_word = false,
			accept_line = false,
			next = "<C-n>",
			prev = "<C-p>",
			dismiss = "<C-e>",
		},
	},
	panel = { enabled = false },
	filetypes = {
		TelescopePrompt = false,
		["neo-tree-popup"] = false,
	},
})
