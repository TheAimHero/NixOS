require("project").setup({
	manual_mode = false,
	use_lsp = true,
	patterns = { "package.json", ".git", "go.mod", "Session.vim" },
	ignore_lsp = {},
	exclude_dirs = { "/home/vedant" },
	show_hidden = true,
	silent_chdir = true,
	scope_chdir = "global",
	datapath = vim.fn.stdpath("data"),
})
local extension = require("telescope").load_extension
extension("projects")
