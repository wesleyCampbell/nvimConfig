---------------------------------------------------------------------------------------------------------
--- plugins.lua
---
--- Description:
------ Loads all nvim plugins
---------------------------------------------------------------------------------------------------------

local lsp_functionality_plugins = require("lsp_functionality_plugin")
local cscope_plugin = require("cscope_plugin")
local nvim_tree_plugin = require("nvim-tree_plugin")
local visuals = require("visuals")
local java = require("java")

return {
	
	lsp_functionality_plugins.blink_cmp_config,
	lsp_functionality_plugins.lspconfig_config,
	lsp_functionality_plugins.nvim_treesitter_config,

	nvim_tree_plugin.nvim_tree_config,

	nvim_tree_plugin.nvim_tree_dep__nvim_web_devicons,

	visuals.plugin__rose_pine_config,
	visuals.plugin__everforest_config,
	visuals.plugin__catppuccin_config,

	cscope_plugin.cscope_config,

	cscope_plugin.cscope_dep__snacks_config,
}


