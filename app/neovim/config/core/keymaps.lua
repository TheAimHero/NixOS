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

-- Windows
keymap("n", "<leader>wo", "<cmd>only<cr>", { desc = "Only" })
keymap("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
keymap("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
keymap("n", "<leader>wx", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- Buffers
keymap("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Find" })
keymap("n", "<leader>bc", "<cmd>silent! %bd<cr>", { desc = "Close Buffer" })

-- Clear search highlight
keymap("n", "<leader>h", "<cmd>silent! nohlsearch<cr>", { desc = "Remove Highlight" })
