require("trouble").setup({
	padding = false,
	use_diagnostic_signs = true,
	auto_close = true,
	auto_fold = false,
	action_keys = {},
	modes = {
		lsp_document_symbols = {
			win = { size = 40, position = "right" },
			preview = { size = 20, type = "split", position = "bottom", wo = { foldenable = false } },
		},
	},
})
