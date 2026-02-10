local keymap = vim.keymap.set

local neocodeium = require("neocodeium")
local catppuccin = require("catppuccin")

local eyelinerStatus = false
local colorSchemeStatus = false
local completionStatus = false

require("snacks").setup({
	bigfile = { enabled = true },
	toggle = { enabled = true },
	terminal = { enabled = true },
	rename = { enabled = true },
	git = { enabled = true },
	scratch = { enabled = true, ft = "markdown" },
	bufdelete = { enabled = true },
	statuscolumn = {
		enabled = true,
		folds = { open = true },
	},
})

keymap("n", "<leader>ur", "<cmd>lua Snacks.rename.rename_file()<cr>", { desc = "Rename File" })
keymap("n", "<leader>uz", "<cmd>lua Snacks.zen()<cr>", { desc = "Zen Mode" })
keymap("n", "<leader>c", "<cmd>lua Snacks.bufdelete()<cr>", { desc = "Delete Buffer" })
keymap("n", "<leader>t", "<cmd>lua Snacks.terminal.open()<cr>", { desc = "Terminal" })
keymap("n", "<leader>.", "<cmd>lua Snacks.scratch()<cr>", { desc = "Scratch Buffer" })
keymap("n", "<leader>S", "<cmd>lua Snacks.scratch.select()<cr>", { desc = "Select Scratch Buffer" })

local snacksInit = function()
	Snacks.toggle.option("spell", { name = "Spelling" }):map("\\s")
	Snacks.toggle.option("wrap", { name = "Wrap" }):map("\\w")
	Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("\\c")
	Snacks.toggle.diagnostics():map("\\d")
	Snacks.toggle.inlay_hints():map("\\h")

	-- Toggle NeoCodeium
	Snacks.toggle
		.new({
			name = "NeoCodeium",
			get = function()
				local status, _ = neocodeium.get_status()
				if status == 1 then
					return false
				end
				return true
			end,
			set = function(value)
				if value then
					vim.cmd("NeoCodeium enable")
					return
				end
				vim.cmd("NeoCodeium disable")
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
				if completionStatus == true then
					completionStatus = false
					return false
				end
				completionStatus = true
				return true
			end,
			set = function(value)
				if value then
					vim.cmd(":lua require('cmp').setup( { enabled = true })")
					return
				end
				vim.cmd(":lua require('cmp').setup( { enabled = false })")
			end,
		})
		:map("\\l")
end
snacksInit()
