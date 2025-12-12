vim.lsp.config('gopls', {
	on_attach = function(client, bufnr)
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	settings = {},
})
vim.lsp.enable('gopls')
