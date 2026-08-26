------------------------------------------------------------------------------
--- plugins
--- 
--- Author:
------ Wesley Campbell
---
--- Description:
------ This module automatically imports all plugins located within the 
------ `plugins` directory. To import a new plugin, simply create a new lua
------ file within the directory and return a table containing the configuration
------ tables for the plugin and its dependencies. Reference current plugin files
------ for examples. 
---------------------------------------------------------------------------------

local luaFetch = require("lib.fetch_lua_files")

DIR_PATH = "~/.config/nvim/lua/plugins"

------------------------------------------------------------------------------
--- PRIVATE FUNCTION loadPlugins
---
--- Description:
------ Will load all plugin configurations from a given directory into a table,
------ which is returned.
---
--- :param dirPath : The path of the directory in which the plugin files are 
------ stored
------------------------------------------------------------------------------
function loadPlugins(dirPath) 
	local plugins = luaFetch.getLuaModuleFileNames(dirPath)
	local configs = {}

	for _, plugin in pairs(plugins) do
		local pluginConfig = require("plugins" .. "." .. plugin)

		-- We need a flat array, not nested, thus we insert each configuration
		-- from the returned table of tables.
		for _, config in pairs(pluginConfig) do
			table.insert(configs, config)
		end
	end

	return configs
end

------------------------------------------------------------------------------
--- PUBLIC LIBRARY INTERFACE
------------------------------------------------------------------------------

return loadPlugins(DIR_PATH)
