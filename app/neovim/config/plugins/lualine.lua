-- function to process get_status() and set buffer variable to that data.
local neocodeium = require("neocodeium")
local function get_neocodeium_status(ev)
	local status, server_status = neocodeium.get_status()
	-- process this data, convert it to custom string/icon etc and set buffer variable

	-- Tables to map serverstatus and status to corresponding symbols
	local server_status_symbols = {
		[0] = "󰣺 ", -- Connected
		[1] = "󱤚 ", -- Connecting
		[2] = "󰣽 ", -- Disconnected
	}

	local status_symbols = {
		[0] = "󰚩 ", -- Enabled
		[1] = "󱚧 ", -- Disabled Globally
		[3] = "󱚢 ", -- Disabled for Buffer filetype
		[5] = "󱚠 ", -- Disabled for Buffer encoding
		[2] = "󱙻 ", -- Disabled for Buffer (catch-all)
	}

	-- Handle serverstatus and status fallback (safeguard against any unexpected value)
	local luacodeium = server_status_symbols[server_status] or "󰣼 "
	luacodeium = luacodeium .. (status_symbols[status] or "󱙻 ")
	vim.api.nvim_buf_set_var(ev.buf, "neocodeium_status", luacodeium)
end

-- Then only some of event fired we invoked this function
vim.api.nvim_create_autocmd("User", {
	group = ..., -- set some augroup here
	pattern = {
		"NeoCodeiumServerConnecting",
		"NeoCodeiumServerConnected",
		"NeoCodeiumServerStopped",
		"NeoCodeiumEnabled",
		"NeoCodeiumDisabled",
		"NeoCodeiumBufEnabled",
		"NeoCodeiumBufDisabled",
	},
	callback = get_neocodeium_status,
})

require("lualine").setup({
	options = {
		theme = "auto",
		icons_enabled = true,
		component_separators = { left = " ", right = " " },
		section_separators = { left = " ", right = " " },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			"filename",
			{ -- NeoCodeium Status
				function()
					return vim.b.neocodeium_status or "󰣽 "
				end,
			},
			{ "os.date('%I:%M %p')", icons_enabled = true, color = { fg = "#ff9e64" }, icon = "󰞌" },
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {
		"fugitive",
		"trouble",
		"nvim-tree",
		"symbols-outline",
		"neo-tree",
	},
})
