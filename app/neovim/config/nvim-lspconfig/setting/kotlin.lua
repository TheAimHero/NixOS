vim.lsp.config("kotlin_language_server", {
	---@diagnostic disable-next-line: unused-local
	on_attach = function(client, bufnr)
		Handlers.lsp_keymaps(bufnr)
	end,
	capabilities = Handlers.capabilities,
	settings = {
		kotlin = {
			compiler = {
				jvm = {
					target = "17",
				},
			},
			linting = {
				debounceTime = 250,
			},
			completion = {
				snippets = {
					enabled = true,
				},
			},
			externalSources = {
				useKlsScheme = true,
				autoConvertToKotlin = true,
			},
			indexing = {
				enabled = true,
			},
		},
	},
	init_options = {
		storagePath = vim.fn.stdpath("cache") .. "/kotlin_language_server",
	},
	root_markers = {
		"settings.gradle",
		"settings.gradle.kts",
		"build.gradle",
		"build.gradle.kts",
		".git",
	},
})
vim.lsp.enable("kotlin_language_server")
