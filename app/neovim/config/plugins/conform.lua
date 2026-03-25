require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		python = { "black" },
		lua = { "stylua" },
		nix = { "nixpkgs_fmt" },
		go = { "gofmt" },
	},
	format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
	formatters = {},
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
