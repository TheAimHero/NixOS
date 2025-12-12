vim.lsp.config('eslint', {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json", "jsonc" },
	settings = {
		eslint = {
			runtime = "eslint_d",
			validate = "on",
			format = false,
		},
	},
})
vim.lsp.enable('eslint')
