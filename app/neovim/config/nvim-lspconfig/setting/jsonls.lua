vim.lsp.config('jsonls', {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
vim.lsp.enable('jsonls')
