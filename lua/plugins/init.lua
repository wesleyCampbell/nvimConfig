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
--- @param dirPath : The path of the directory in which the plugin files are 
------ stored
------------------------------------------------------------------------------
function loadPlugins(dirPath) 
	local plugins = luaFetch.getLuaModuleFileNames(dirPath)
	local configs = {}
	local configFuncs = {}

	for _, plugin in ipairs(plugins) do
		local moduleName = "plugins" .. "." .. plugin
		local pluginConfig = require(moduleName)

		-- Check to see if the plugin has a config function associated with it. If it does, add it to the `configFuncs` table for future use and remove it from the `pluginConfig` table as it is not needed for this opperation.
		local configFunc = rawget(pluginConfig, "configFunc")
		if configFunc then
			assert(
				type(configFunc) == "function",
				moduleName .. ".configFunc must be a function!"
			)
			configFuncs[moduleName] = configFunc
		end
		
		-- We need a flat array, not nested, thus we insert each configuration
		-- from the returned table of tables.
		for _, config in ipairs(pluginConfig) do
			table.insert(configs, config)
		end
	end

	return configs, configFuncs
end

------------------------------------------------------------------------------
--- PRIVATE FUNCTION runConfigFuncs
---
--- Description:
------ Will call all the functions in a table additional plugin configurations
------ That have to wait until after Lazy loads the plugins. The table must 
------ be in the configuration { "pluginName": pluginConfigFunc, ... }.
---
--- @param configFuncTable : The table containing each plugin configuration
------ function in the configuration  {"pluginName": pluginConfigFunc, ... }
------------------------------------------------------------------------------
function runConfigFuncs(configFuncTable) 
	for moduleName, func in pairs(configFuncTable) do
		if not pcall(func) then
			print("[ERROR] in " .. moduleName .. ".configFunc")
		end
	end
end

------------------------------------------------------------------------------
--- PUBLIC LIBRARY INTERFACE
------------------------------------------------------------------------------

-- return loadPlugins(DIR_PATH)
_pluginConfigs, _configFuncs = loadPlugins(DIR_PATH)

------------------------------------------------------------------------------
--- PRIVATE FUNCTION main
---
--- Description:
------ Entry point into the program. Calls `runConfigFuncs` with the loaded
------ plugin configuration functions.
------------------------------------------------------------------------------
function _main() 
	runConfigFuncs(_configFuncs)
end

return {
	pluginConfigs = _pluginConfigs,
	configurePlugins = _main
	-- pluginConfigFuncs = _configFuncs,
}
