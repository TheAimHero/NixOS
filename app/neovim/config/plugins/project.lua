require("project").setup({
	manual_mode = false,
	patterns = { ".git", "Session.vim" },
	lsp = { ignore = {} },
	exclude_dirs = { "/home/vedant" },
	show_hidden = true,
	silent_chdir = true,
	scope_chdir = "global",
	history = { save_dir = vim.fn.stdpath("data") },
})
local extension = require("telescope").load_extension
extension("projects")
