-- NVIM-tree keybinds
vim.keymap.set('n', '<C-Shift-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

-- -- NAVIGATION KEYBINDS -- -- 
-- Up and right
vim.keymap.set('n', '<C-e>lk', '[[<C-w>l<C-w>k]]', {noremap = true, silent = true})
vim.keymap.set('n', '<C-e>kl', '[[<C-w>k<C-w>l]]', {noremap = true, silent = true})

-- Up and left
vim.keymap.set('n', '<C-e>hk', '[[<C-w>h<C-w>k]]', {noremap = true, silent = true})
vim.keymap.set('n', '<C-e>kh', '[[<C-w>k<C-w>h]]', {noremap = true, silent = true})

-- Down and right
vim.keymap.set('n', '<C-e>lj', '[[<C-w>l<C-w>j]]', {noremap = true, silent = true})
vim.keymap.set('n', '<C-e>jl', '[[<C-w>j<C-w>l]]', {noremap = true, silent = true})

-- Down and left
vim.keymap.set('n', '<C-e>hj', '[[<C-w>h<C-w>j]]', {noremap = true, silent = true})
vim.keymap.set('n', '<C-e>jh', '[[<C-w>j<C-w>h]]', {noremap = true, silent = true})

-- FOLD METHOD FUNCTIONS
vim.keymap.set('n', 'zz', ':set foldmethod=indent<CR>', {noremap = true, silent = true})


-- INSERT NEW LINE SHORTCUTS

local function apply_count_to_function(func)
	local count = vim.v.count1
	for _ = 1,count do
		func()
	end
end

local function new_line_below()
	vim.cmd('normal! o')
	vim.cmd('stopinsert')
	vim.cmd('normal! k')
end

local function new_line_above()
	vim.cmd('normal! O')
	vim.cmd('stopinsert')
	vim.cmd('normal! j')
end

local function new_line_above_below()
	new_line_below()
	new_line_above()
end

vim.keymap.set('n', '<Enter>', function() apply_count_to_function(new_line_below) end, {noremap = true, silent = true})
vim.keymap.set('n', '<S-CR>', function() apply_count_to_function(new_line_above) end, {noremap = true, silent = true})
vim.keymap.set('n', '<C-CR>', function() apply_count_to_function(new_line_above_below) end, {noremap = true, silent = true}) 
