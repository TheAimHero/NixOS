local clangd_capabilities = vim.deepcopy(Handlers.capabilities)
clangd_capabilities.textDocument.semanticHighlighting = true
clangd_capabilities.offsetEncoding = "utf-8"
vim.lsp.config('clangd', {
	on_attach = function(client, bufnr)
		-- client.server_capabilities.documentFormattingProvider = false
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = clangd_capabilities,
	cmd = { "clangd" },
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = false,
	},
})
vim.lsp.enable('clangd')
