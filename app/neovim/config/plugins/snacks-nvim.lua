local keymap = vim.keymap.set

local catppuccin = require("catppuccin")

local eyelinerStatus = false
local colorSchemeStatus = false

require("snacks").setup({
	bigfile = { enabled = true },
	toggle = { enabled = true },
	terminal = { enabled = true },
	rename = { enabled = true },
	scratch = {
		enabled = true,
		ft = "markdown",
		win = {
			position = "right",
			width = 0.4,
			bo = { buflisted = true },
		},
	},
	bufdelete = { enabled = true },
	statuscolumn = {
		enabled = true,
		folds = { open = true },
	},
	notifier = {
		enabled = true,
		timeout = 3000,
		style = "compact",
	},
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ section = "recent_files", limit = 5, padding = 1 },
		},
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
				{ icon = " ", key = "p", desc = "Projects", action = ":Telescope projects" },
				{ icon = " ", key = "g", desc = "Neogit", action = ":Neogit" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			header = [[
  /\ \▔\___  ___/\   /(●)_ __ ___
 /  \/ / _ \/ _ \ \ / / | '_ ` _ \
/ /\  /  __/ (_) \ V /| | | | | | |
\_\ \/ \___|\___/ \_/ |_|_| |_| |_|
───────────────────────────────────]],
		},
	},
	indent = {
		enabled = true,
		char = "│",
		scope = { enabled = true },
	},
})

-- Override vim.notify
vim.notify = Snacks.notifier.notify

keymap("n", "<leader>ur", "<cmd>lua Snacks.rename.rename_file()<cr>", { desc = "Rename File" })
keymap("n", "<leader>uz", "<cmd>lua Snacks.zen()<cr>", { desc = "Zen Mode" })
keymap("n", "<leader>q", "<cmd>lua Snacks.bufdelete()<cr>", { desc = "Delete Buffer" })
keymap("n", "<leader>t", "<cmd>lua Snacks.terminal.open()<cr>", { desc = "Terminal" })
keymap("n", "<leader>.", "<cmd>lua Snacks.scratch()<cr>", { desc = "Scratch Buffer" })
keymap("n", "<leader>S", "<cmd>lua Snacks.scratch.select()<cr>", { desc = "Select Scratch Buffer" })
keymap("n", "<leader>un", "<cmd>lua Snacks.notifier.show_history()<cr>", { desc = "Notification History" })

local snacksInit = function()
	Snacks.toggle.option("spell", { name = "Spelling" }):map("\\s")
	Snacks.toggle.option("wrap", { name = "Wrap" }):map("\\w")
	Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("\\c")
	Snacks.toggle.diagnostics():map("\\d")
	Snacks.toggle.inlay_hints():map("\\h")

	-- Toggle Copilot
	Snacks.toggle
		.new({
			name = "Copilot",
			get = function()
				local ok, copilot = pcall(require, "copilot.client")
				if not ok then
					return false
				end
				return copilot.is_attached()
			end,
			set = function(value)
				if value then
					vim.cmd("Copilot enable")
					return
				end
				vim.cmd("Copilot disable")
			end,
		})
		:map("\\a")

	-- Toggle Eyeliner
	Snacks.toggle
		.new({
			name = "Eyeliner",
			get = function()
				if eyelinerStatus == true then
					eyelinerStatus = false
					return false
				end
				eyelinerStatus = true
				return true
			end,
			set = function(value)
				if value then
					vim.cmd("EyelinerEnable")
					return
				end
				vim.cmd("EyelinerDisable")
			end,
		})
		:map("\\e")

	-- Toggle Catppuccin
	Snacks.toggle
		.new({
			name = "Color Scheme",
			get = function()
				if colorSchemeStatus == true then
					colorSchemeStatus = false
					return false
				end
				colorSchemeStatus = true
				return true
			end,
			set = function(value)
				if value then
					vim.cmd("colorscheme catppuccin-mocha")
					return
				end
				vim.cmd("colorscheme catppuccin-frappe")
			end,
		})
		:map("\\b")

	-- Toggle Transparency
	Snacks.toggle
		.new({
			name = "Transparency",
			get = function()
				return catppuccin.options.transparent_background
			end,
			set = function()
				catppuccin.options.transparent_background = not catppuccin.options.transparent_background
				catppuccin.compile()
				vim.cmd.colorscheme(vim.g.colors_name)
			end,
		})
		:map("\\t")

	-- Toggle Completion
	Snacks.toggle
		.new({
			name = "Completion",
			get = function()
				return vim.b.completion ~= false
			end,
			set = function(value)
				vim.b.completion = value
			end,
		})
		:map("\\l")
end
snacksInit()
