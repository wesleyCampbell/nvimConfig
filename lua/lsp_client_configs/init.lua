------------------------------------------------------------------------------
--- lsp_client_configs
--- 
--- Author:
------ Wesley Campbell
---
--- Description:
------ This module automatically imports LSP server configuration files from the 
------ lsp_client_configs directory into the lspconfig file. To import a new 
------ LSP configuration, simply create a new .lua file within the directory
------ and return a table with two entries: these being `name` and `config`.
------ `name` obviously contains the name of the LSP server, e.g. 'clangd'.
------ `config` will point to a table containing the LSP configuration. For 
------ examples, reference current examples within the directory.
------------------------------------------------------------------------------

local lua_fetch = require("lib.fetch_lua_files")

DIR_PATH = "~/.config/nvim/lua/lsp_client_configs"

------------------------------------------------------------------------------
--- PRIVATE FUNCTION loadClientConfigs
---
--- Description:
------ Given a table of modules to load and the directory in which they are 
------ stored, this function will load the config into the lspconfig plugin.
---
--- :param modules : table<Stirng> An array containing the filenames of all the
------ config modules to load
--- :param dir_path : The path of the directory in which the config files are 
------ stored
------------------------------------------------------------------------------
function loadClientConfigs(modules, dir_path) 
	for _, module in pairs(modules) do
		local module_package = require(dir_path .. "." .. module)

		-- Extract necessary information from module
		local server_name = module_package.name
		local server_config = module_package.config

		-- Import config into lspconfig. Note that lspconfig tied to Debian stable's 
		-- Neovim version is out of date and requires a legacy call. This requires 
		-- us to check to see if the modern method exists. If not, we call legacy.
		-- If it does, we can use the up to date method.
		if not vim.lsp.config then
			local lspconfig = require("lspconfig")

			lspconfig[server_name].setup(server_config)
		else
			vim.lsp.config(server_name, server_config)
		end
	end

end


-----------------------------------------------------------------------------
--- PRIVATE FUNCTION _main
---
--- Description:
------- Starting point for the program. Will load all the configuration files
------- for each LSP server
-----------------------------------------------------------------------------
function _main()
	local files = lua_fetch.getLuaModuleFileNames(DIR_PATH)

	loadClientConfigs(files, "lsp_client_configs")
end

------------------------------------------------------------------------------
--- PUBLIC LIBRARY INTERFACE
------------------------------------------------------------------------------

return {
	loadConfigs = _main,
}

