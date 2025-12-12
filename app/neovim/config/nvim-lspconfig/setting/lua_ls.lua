vim.lsp.config('lua_ls', {
	on_attach = function(client, bufnr)
		Handlers.lsp_keymaps(bufnr)
		client.server_capabilities.documentFormattingProvider = false
	end,
	capabilities = Handlers.capabilities,
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	log_level = 2,
	single_file_support = true,
	settings = {
		Lua = {
			hint = { enable = true },
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.enable('lua_ls')
