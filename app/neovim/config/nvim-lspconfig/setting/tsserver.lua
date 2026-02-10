vim.lsp.config("ts_ls", {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	init_options = {
		hostInfo = "neovim",
	},
	settings = {
		typescript = {
			inlayHints = {
				includeInlayFunctionParameterTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
			},
			preferences = {
				importModuleSpecifier = "non-relative",
			},
		},
		javascript = {
			inlayHints = {
				includeInlayFunctionParameterTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
			},
			preferences = {
				importModuleSpecifier = "non-relative",
			},
		},
		tsserver = {
			maxTsServerMemory = 2048,
		},
	},
})
vim.lsp.enable("ts_ls")
