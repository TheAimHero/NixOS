local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local hover = null_ls.builtins.hover
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	border = "single",
	-- @note: this is for automatic formatting on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,

	sources = {
		diagnostics.actionlint,
		diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),

		formatting.prettierd,
		formatting.stylua,
		formatting.gofmt,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.nixpkgs_fmt,
		formatting.clang_format.with({
			extra_args = {
				"--style",
				"{AllowShortBlocksOnASingleLine: SBS_Always, AllowShortIfStatementsOnASingleLine: SIS_Always }",
			},
		}),
		formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),

		hover.dictionary,
		hover.printenv,
	},
})
