local tables = require("tables")
-- Changes tab spacing to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Enables line numbers
-- vim.cmd("set relativenumber")
vim.cmd("set number")

-- Enables 24 bit colors 
vim.opt.termguicolors = true 

--//==========================================\\--
--|               FUNCTIONS                    | 
--\\==========================================//--

function toggleLineNumberType()
	if vim.opt.number:get() then
		vim.cmd("set nonumber")
		vim.cmd("set relativenumber")
	elseif vim.opt.relativenumber:get() then
		vim.cmd("set norelativenumber")
		vim.cmd("set number")
	else
		vim.cmd("set number")
	end
end

function themeEverforestSet()
	vim.g.everforest_enable_italic = true
	vim.g.everforest_background = "hard"
	local colors = {
		bg0 = { "#1E2326", "30" },
		bg4 = { "#3f5865", "30" },  -- Sets the accent division to blue
		-- bg4 = { "#40584e", "30" }, -- Sets the accent division to green
		blue = { "#7FCBD3", "245" }
	}
	vim.g.everforest_colors_override = colors
	vim.cmd("colorscheme everforest")
end

function themeCappuchinoSet()
	vim.cmd("colorscheme catppuccin")
end

function themeRosePineSet()
	vim.cmd("colorscheme rose-pine")
end

--//==========================================\\--
--|                  MAIN                      |
--\\==========================================//--

local defaultTheme = "everforest"
local currentTheme = defaultTheme
local themeTable = {
	["rose-pine"] = themeRosePineSet,
	["everforest"] = themeEverforestSet,
	["catppuccin"] = themeCappuchinoSet,
}
local themeTableIndexes = tables.makeIndexTable(themeTable)

function setDefaultTheme()
	setTheme(defaultTheme)	
end

function setTheme(theme)
	local func = themeTable[theme]
	if (func) then
		func()
		currentTheme = theme
	else
		print("[[ERROR]] in <visuals.lua>: The theme "..theme.." does not exist...")
	end
end

function rotateTheme()
	local curIndex = tables.getTableIndex(themeTableIndexes, currentTheme)

	-- Check to see if currentTheme is in the list
	if (curIndex < 0) then
		print("[[ERROR]] in <visuals.lua>: Theme "..currentTheme.." not found in theme database...")
		return
	-- If the item is not the last, simply increment it by one
	elseif (curIndex < themeTableIndexes["len"] - 1) then
		curIndex = curIndex + 1
	-- If the current index is the last item, restart at the first
	else
		curIndex = 0
	end

	local newTheme = themeTableIndexes[curIndex]
	print("Changing theme from "..currentTheme.." to "..newTheme)
	setTheme(newTheme)
end

--//==========================================\\--
--|               KEYBINDS                     | 
--\\==========================================//--

vim.keymap.set('n', '<C-t><C-n>', function () toggleLineNumberType() end, {noremap = true, silent = true})

vim.keymap.set('n', '<C-t><C-t>', function () rotateTheme() end, {noremap = true, silent = true})

--//==========================================\\--
--|                GLOBAL                      | 
--\\==========================================//--

local _plugin__rose_pine_config = {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		setDefaultTheme()
	end
}

local _plugin__everforest_config = {
	"sainnhe/everforest",
	name = "everforest",
	config = function()
		setDefaultTheme()
	end
}
local _plugin__catppuccin_config = {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		setDefaultTheme()
	end
}

return {
	plugin__rose_pine_config = _plugin__rose_pine_config,
	plugin__everforest_config = _plugin__everforest_config,
	plugin__catppuccin_config = _plugin__catppuccin_config 
}
