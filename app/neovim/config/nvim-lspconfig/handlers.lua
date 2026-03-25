Handlers = {}

Handlers.capabilities = vim.lsp.protocol.make_client_capabilities()
Handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true
Handlers.capabilities = require("blink.cmp").get_lsp_capabilities(Handlers.capabilities)


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
	keymap("n", "K", function()
		vim.lsp.buf.hover({ border = "single" })
	end, vim.tbl_extend("force", opts, { desc = "Hover" }))
	keymap(
		"n",
		"<leader>ll",
		"<cmd>lua vim.diagnostic.open_float()<cr>",
		vim.tbl_extend("force", opts, { desc = "Line Diagnostics" })
	)
	keymap(
		"n",
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<cr>",
		vim.tbl_extend("force", opts, { desc = "Code Actions" })
	)
	keymap(
		"n",
		"<leader>li",
		"<cmd>lua vim.lsp.buf.implementation()<CR>",
		vim.tbl_extend("force", opts, { desc = "LSP Implementation" })
	)
	keymap("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", vim.tbl_extend("force", opts, { desc = "LSP Rename" }))
	keymap(
		"n",
		"<leader>lr",
		"<cmd>Trouble lsp_references toggle focus=true<cr>",
		vim.tbl_extend("force", opts, { desc = "LSP References" })
	)
	keymap(
		"n",
		"<leader>lt",
		"<cmd>Trouble lsp_type_definitions toggle focus=true<cr>",
		vim.tbl_extend("force", opts, { desc = "LSP Type Definitions" })
	)
	keymap(
		"n",
		"<leader>ld",
		"<cmd>Trouble diagnostics toggle focus=true multiline=true filter.buf=0<cr>",
		vim.tbl_extend("force", opts, { desc = "Buffer Diagnostics (Trouble)" })
	)
	keymap(
		"n",
		"<leader>lw",
		"<cmd>Trouble diagnostics toggle focus=true multiline=true<cr>",
		vim.tbl_extend("force", opts, { desc = "Diagnostics (Trouble)" })
	)
	keymap(
		"n",
		"<leader>ls",
		"<cmd>Trouble lsp_document_symbols toggle focus=true<cr>",
		vim.tbl_extend("force", opts, { desc = "Symbols (Trouble)" })
	)
	keymap(
		"n",
		"gd",
		"<cmd>Trouble lsp_definitions toggle focus=true<cr>",
		vim.tbl_extend("force", opts, { desc = "Goto Definition" })
	)
end

Handlers.setup()
