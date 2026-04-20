-- LSP configuration for Zig (zls)
local zls_capabilities = vim.deepcopy(Handlers.capabilities)

vim.lsp.config("zls", {
	on_attach = function(client, bufnr)
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = zls_capabilities,
	cmd = { "zls" },
})
vim.lsp.enable("zls")
