local keymap = vim.keymap.set

-- Enhanced text objects (no snacks alternative)
require("mini.ai").setup({ silent = true })

-- Basic mappings & options (no snacks alternative)
require("mini.basics").setup({
	options = { extra_ui = false, win_borders = "single" },
	mappings = { basic = true, option_toggle_prefix = "", windows = true, move_with_alt = false },
	autocommands = { basic = false, relnum_in_visual_mode = false },
	silent = true,
})

-- Commenting with treesitter context (no snacks alternative)
require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})
vim.g.skip_ts_context_commentstring_module = true

-- Split/join code blocks (no snacks alternative)
require("mini.splitjoin").setup({ mappings = { toggle = "<leader>us" } })

-- Auto pairs (no snacks alternative)
require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = true } })

-- Move lines/selections (no snacks alternative)
require("mini.move").setup()

-- Highlight patterns like TODO, hex colors (no snacks alternative)
require("mini.hipatterns").setup({
	highlighters = {
		fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	},
})

-- Session management (no snacks alternative)
require("mini.sessions").setup()
keymap("n", "<leader>uo", [[<cmd>lua MiniSessions.write("Session.vim")<cr>]], { desc = "Session Save" })

-- Bracketed navigation (no snacks alternative)
require("mini.bracketed").setup({
	jump = { suffix = "", options = {} },
	location = { suffix = "", options = {} },
	undo = { suffix = "", options = {} },
	yank = { suffix = "", options = {} },
	comment = { suffix = "", options = {} },
})
