local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local disable_table = {
	"toggleterm",
	"DiffviewFileHistory",
	"diff",
	"neo-tree",
	"DiffviewFiles",
	"lazy",
	"mason",
	"Trouble",
	"Outline",
	"fugitive",
	"git",
	"TelescopPrompt",
	"help",
	"man",
	"terminal",
	"qf",
	"nowrite",
	"norg",
	"trouble",
	"leetcode.nvim",
}

--Disable mini on some filetype
augroup("Disable_Plugins", { clear = true })
autocmd({ "FileType" }, {
	pattern = disable_table,
	group = "Disable_Plugins",
	callback = function()
		vim.b.miniindentscope_disable = true
		vim.b.minicursorword_disable = true
		vim.b.minijump_disable = true
	end,
})

autocmd("FileType", {
	pattern = { "Outline", "neo-tree", "trouble" },
	callback = function()
		vim.opt.foldenable = false
		vim.wo.foldcolumn = "0"
	end,
})

-- @note: This is when we want to do something before closing a buffer
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function()
		vim.cmd("mkview")
	end,
	group = save_fold,
})

-- Show snacks dashboard when all file buffers are closed
augroup("snacks_dashboard_on_empty", { clear = true })
autocmd({ "BufDelete", "BufWipeout" }, {
	group = "snacks_dashboard_on_empty",
	callback = function(event)
		-- Don't re-open when the dashboard buffer itself is deleted
		if vim.bo[event.buf].filetype == "snacks_dashboard" then
			return
		end
		-- Defer to let the buffer deletion complete first
		vim.schedule(function()
			-- Check if any real file-backed buffers remain
			local has_real_buffer = false
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then
					local name = vim.api.nvim_buf_get_name(buf)
					local ft = vim.bo[buf].filetype
					-- A "real" buffer has a name or a meaningful filetype
					if name ~= "" or (ft ~= "" and ft ~= "snacks_dashboard") then
						has_real_buffer = true
						break
					end
				end
			end
			if not has_real_buffer then
				-- Close all other windows first so dashboard takes full screen
				local current_win = vim.api.nvim_get_current_win()
				for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
					if win ~= current_win and vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_win_close(win, true)
					end
				end
				-- Use current buffer/window so it's non-float, full-screen
				Snacks.dashboard({ buf = 0, win = 0 })
			end
		end)
	end,
})

-- @note: This is when we want to do something after opening a buffer
autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function()
		vim.cmd("silent! loadview")
	end,
	group = save_fold,
})

-- Persistent Cursor
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
