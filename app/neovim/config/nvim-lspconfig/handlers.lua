Handlers = {}

Handlers.capabilities = vim.lsp.protocol.make_client_capabilities()
Handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true
Handlers.capabilities = require("cmp_nvim_lsp").default_capabilities(Handlers.capabilities)

Handlers.setup = function()
	-- diagnostic signs
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, {
			texthl = sign.name,
			text = sign.text,
			numhl = "",
		})
	end

	vim.diagnostic.config({
		virtual_text = { spacing = 5 },
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = { focusable = true, border = "single" },
	})
end

local keymap = vim.keymap.set

Handlers.lsp_keymaps = function(bufnr)
	local opts = { buffer = bufnr, desc = "" }
	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", vim.tbl_extend("force", opts, { desc = "Hover" }))
	keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", vim.tbl_extend("force", opts, { desc = "Line Diagnostics" }))
	keymap("n", "gra", "<cmd>lua vim.lsp.buf.code_action()<cr>", vim.tbl_extend("force", opts, { desc = "Code Actions" }))
	keymap("n", "gri", "<cmd>lua vim.lsp.buf.implementation()<CR>", vim.tbl_extend("force", opts, { desc = "LSP Implementation" }))
	keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<cr>", vim.tbl_extend("force", opts, { desc = "LSP Rename" }))
	keymap("n", "grr", "<cmd>Trouble lsp_references toggle focus=true<cr>", vim.tbl_extend("force", opts, { desc = "LSP References" }))
	keymap("n", "grt", "<cmd>Trouble lsp_type_definitions toggle focus=true<cr>", vim.tbl_extend("force", opts, { desc = "LSP Type Definitions" }))
	keymap("n", "grf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", vim.tbl_extend("force", opts, { desc = "LSP Format" }))
	keymap("i", "<C-v>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", vim.tbl_extend("force", opts, { desc = "LSP Signature" }))
	keymap(
		"n",
		"grd",
		"<cmd>Trouble diagnostics toggle focus=true multiline=true filter.buf=0<cr>",
		vim.tbl_extend("force", opts, { desc = "Buffer Diagnostics (Trouble)" })
	)
	keymap(
		"n",
		"grw",
		"<cmd>Trouble diagnostics toggle focus=true multiline=true<cr>",
		vim.tbl_extend("force", opts, { desc = "Diagnostics (Trouble)" })
	)
	keymap("n", "grs", "<cmd>Trouble lsp_document_symbols toggle focus=true<cr>", vim.tbl_extend("force", opts, { desc = "Symbols (Trouble)" }))
	keymap("n", "gd", "<cmd>Trouble lsp_definitions toggle focus=true<cr>", vim.tbl_extend("force", opts, { desc = "Goto Defination" }))
end

Handlers.setup()
