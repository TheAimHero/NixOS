-- Shorten function name
local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
keymap({ "i", "n" }, "<C-LeftMouse>", "<Nop>", opts)
keymap({ "n", "i", "v" }, "<A-i>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Redo
keymap("n", "U", "<C-r>", opts)

-- Insert Mode
keymap("i", "jk", "<ESC>", opts)
keymap("n", "x", '"_x', opts)

keymap("t", "<C-h>", "<C-\\><C-n><C-h>", opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-j>", opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-k>", opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-l>", opts)


-- Buffers
keymap("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Find" })
keymap("n", "<leader>bc", "<cmd>silent! %bd<cr>", { desc = "Close Buffer" })

-- Clear search highlight
keymap("n", "<leader>h", "<cmd>silent! nohlsearch<cr>", { desc = "Remove Highlight" })

-- Tabs
keymap("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
keymap("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<leader><tab>e", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<leader><tab>1", "<cmd>tabn 1<cr>", { desc = "Tab 1" })
keymap("n", "<leader><tab>2", "<cmd>tabn 2<cr>", { desc = "Tab 2" })
keymap("n", "<leader><tab>3", "<cmd>tabn 3<cr>", { desc = "Tab 3" })
keymap("n", "<leader><tab>4", "<cmd>tabn 4<cr>", { desc = "Tab 4" })
keymap("n", "<leader><tab>5", "<cmd>tabn 5<cr>", { desc = "Tab 5" })
