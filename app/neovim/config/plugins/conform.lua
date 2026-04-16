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
		kotlin = { "ktlint" },
	},
	format_on_save = function(bufnr)
		local timeout = 500
		-- ktlint is slow, especially on first run (JVM startup)
		if vim.bo[bufnr].filetype == "kotlin" then
			timeout = 10000
		end
		return { timeout_ms = timeout, lsp_format = "fallback" }
	end,
	formatters = {
		ktlint = {
			timeout_ms = 10000,
			args = { "--format", "--stdin", "-" },
			stdin = true,
		},
	},
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
