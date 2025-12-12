vim.lsp.config("ts_ls", {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayVariableTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayVariableTypeHints = true,

				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})
vim.lsp.enable("ts_ls")
