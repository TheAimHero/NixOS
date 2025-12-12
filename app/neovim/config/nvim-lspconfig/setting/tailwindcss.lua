vim.lsp.config('tailwindcss', {
	on_attach = function(client, bufnr)
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	filetypes = { "typescriptreact", "javascriptreact", "html", "templ" },
	init_options = { userLanguages = { templ = "html" } },
	-- root_dir = require("lspconfig").util.root_pattern(
	--   "tailwind.config.js",
	--   "tailwind.config.ts",
	--   "tailwind.config.cjs"
	-- ),
	settings = {
		tailwindCSS = {
			experimental = { classRegex = { { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" } } },
		},
	},
})
vim.lsp.enable('tailwindcss')
