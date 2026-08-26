------------------------------------------------------------------------------
--- PRIVATE FUNCTION _getFileName
---
--- Description:
------ Takes in a filename (not path) and returns the filename without the
------ file extension
---
--- :param file : The file to take the filename from
---
---  :return String, String : The filename of the file, the file extension of
------ the file
------------------------------------------------------------------------------
function _getFileName(file) 
	return file:match("^(.+)%.(.+)$")
end

------------------------------------------------------------------------------
--- PRIVATE FUNCTION _getLuaModuleFileNames
---
--- Description:
------ Given a directory path, will return all the names of the lua config files
------ within (excluding the init.lua file)
---
--- :param dir_path : The path to the directory to search
---
---  :return table<String> : A table containing all the filenames of the config
---  files
------------------------------------------------------------------------------
function _getLuaModuleFileNames(dir_path)
	local files = {}

	for file in io.popen("ls -- " .. dir_path):lines() do
		filename, extension = _getFileName(file)
		if (filename ~= "init" and extension == "lua") then
			table.insert(files, filename)
		end
	end

	return files
end

------------------------------------------------------------------------------
--- PUBLIC LIBRARY INTERFACE
------------------------------------------------------------------------------

return {
	getFileName = _getFileName,
	getLuaModuleFileNames = _getLuaModuleFileNames,
}

