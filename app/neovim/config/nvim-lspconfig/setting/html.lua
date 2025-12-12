local capabilities = vim.deepcopy(Handlers.capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('html', {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = capabilities,
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "ejs" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
	settings = {},
	single_file_support = true,
})
vim.lsp.enable('html')
