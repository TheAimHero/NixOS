local function get_copilot_status()
	local ok, copilot = pcall(require, "copilot.client")
	if not ok then
		return "󰣽 "
	end

	local attached = copilot.is_attached()
	if attached then
		return "󰣺 󰚩 " -- Connected + Enabled
	else
		return "󰣽 󱚧 " -- Disconnected + Disabled
	end
end

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
			{ get_copilot_status },
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
