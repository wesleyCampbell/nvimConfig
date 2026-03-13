--//==========================================\\--
--|               FUNCTIONS                    | 
--\\==========================================//--

-- openes a terminal of a gven height and enters in insert mode
function open_sized_terminal(height)
	height = height or 15
	-- vim.cmd("botright split")
	vim.cmd("belowright split")
	vim.cmd("resize " .. height)
	vim.cmd("terminal")
	vim.cmd("startinsert")
end

function open_vs_terminal()
	vim.cmd("vs | terminal")
	vim.cmd("startinsert")
end

function open_hs_terminal(height)
	height = height or 30
	vim.cmd("split | terminal")
	vim.cmd("resize " .. height)
	vim.cmd("startinsert")
end

function manage_terminal(height)
	-- Attatch to current terminal context, if it exists
	local windows = vim.api.nvim_list_wins()
	for _, win in ipairs(windows) do
		local buf = vim.api.nvim_win_get_buf(win)
		local buftype = vim.api.nvim_buf_get_option(buf, "buftype") 

		if buftype == "terminal" then
			vim.api.nvim_set_current_win(win)
			vim.cmd("startinsert")
			return
		end
	end

	-- If there is no current terminal buffer, create one
	open_sized_terminal(height)
end

--//==========================================\\--
--|               COMMANDS                     | 
--\\==========================================//--

vim.api.nvim_create_user_command('Term', function(opts)
	open_sized_terminal(tonumber(opts.fargs[1]))
end, { nargs = '?' })


--//==========================================\\--
--|               KEYBINDS                     | 
--\\==========================================//--

-- Terminal open commands
vim.keymap.set('n', '<C-w>t', function() manage_terminal(15) end, { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>t', function() open_vs_terminal() end, { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>vt', function() open_vs_terminal() end, { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>st', function() open_hs_terminal() end, { noremap = true, silent = true })

-- Terminal Navigation commands

-- -- swap to left window
vim.keymap.set('t', '<C-w>h', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w><C-h>', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })

-- -- Swap to right window
vim.keymap.set('t', '<C-w>l', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w><C-l>', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })

-- -- Swap to upper window
vim.keymap.set('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w><C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })

-- Swap to lower window
vim.keymap.set('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w><C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })

-- Escape terminal mode to normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Up and right
vim.keymap.set('t', '<C-e>lk', '[[<C-w>l<C-w>k]]', {noremap = true, silent = true})
vim.keymap.set('t', '<C-e>kl', '[[<C-w>k<C-w>l]]', {noremap = true, silent = true})

-- Up and left
vim.keymap.set('t', '<C-e>hk', '[[<C-w>h<C-w>k]]', {noremap = true, silent = true})
vim.keymap.set('t', '<C-e>kh', '[[<C-w>k<C-w>h]]', {noremap = true, silent = true})

-- Down and right
vim.keymap.set('t', '<C-e>lj', '[[<C-w>l<C-w>j]]', {noremap = true, silent = true})
vim.keymap.set('t', '<C-e>jl', '[[<C-w>j<C-w>l]]', {noremap = true, silent = true})

-- Down and left
vim.keymap.set('t', '<C-e>hj', '[[<C-w>h<C-w>j]]', {noremap = true, silent = true})
vim.keymap.set('t', '<C-e>jh', '[[<C-w>j<C-w>h]]', {noremap = true, silent = true})
