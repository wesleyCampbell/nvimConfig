------------------------------------------------------------------------------
--- custom_configs
--- 
--- Author:
------ Wesley Campbell
---
--- Description:
------ This modules contains and automatically loads miscellaneous software 
------ functionality that I write. These can include keybinds, custom terminal
------ behaviour, etc. 
---------------------------------------------------------------------------------

local luaFetch = require("lib.fetch_lua_files")

DIR_PATH = "~/.config/nvim/lua/custom_configs/"

------------------------------------------------------------------------------
--- PRIVATE FUNCTION loadConfigs
---
--- Description:
------ Will load all custom configurations from a given directory into a table,
------ which is returned.
---
--- :param dirPath : The path of the directory in which the plugin files are 
------ stored
------------------------------------------------------------------------------
function _loadConfigs(dirPath)
	local modules = luaFetch.getLuaModuleFileNames(dirPath)

	for _, module in pairs(modules) do
		local moduleConfig = require("custom_configs" .. "." .. module)
	end
end	

------------------------------------------------------------------------------
--- PUBLIC LIBRARY INTERFACE
------------------------------------------------------------------------------

function main() 
	_loadConfigs(DIR_PATH)
end

return {
	loadConfigs = main,
}

