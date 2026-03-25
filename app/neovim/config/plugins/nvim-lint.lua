require("lint").linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	yaml = { "actionlint" },
	sql = { "sqlfluff" },
}

-- Configure sqlfluff for postgres
require("lint").linters.sqlfluff.args = {
	"lint",
	"--format=json",
	"--dialect=postgres",
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
