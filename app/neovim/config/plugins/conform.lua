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
		zig = { "lsp" },
	},
	format_on_save = function(bufnr)
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
