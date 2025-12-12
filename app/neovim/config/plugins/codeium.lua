local neocodeium = require("neocodeium")
local keymap = vim.keymap.set

neocodeium.setup({
	debounce = true,
	silent = true,
	filetypes = { TelescopePrompt = false, ["neo-tree-popup"] = false },
})
keymap("i", "<C-f>", function()
	neocodeium.accept()
end)
keymap("i", "<C-e>", function()
	neocodeium.clear()
end)
keymap("i", "<C-n>", function()
	neocodeium.cycle(1)
end)
keymap("i", "<C-p>", function()
	neocodeium.cycle(-1)
end)
