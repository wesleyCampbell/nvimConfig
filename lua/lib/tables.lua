------------------------------------------------------------------------------
--- tables.lua
--- 
--- Author:
------ Wesley Campbell
---
--- Description:
------ Provides several library functions for managing tables in lua
---
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--- PRIVATE FUNCTION _getTableIndex
---
--- Description:
------ Searches and returns the index of an item in a table, if it exists or -1
---
--- :param table : the table to search
--- :param item : the item to search for in the table
---
--- :return int : index of item, or -1 if not in list
------------------------------------------------------------------------------
function _getTableIndex(table, item)
	local i = 0
	for _, value in pairs(table) do
		if (item == value) then
			return i
		end
		i = i + 1
	end
	return -1
end

------------------------------------------------------------------------------
--- PRIVATE FUNCTION _makeIndexTable
---
--- Description:
------ Given a mapped table, return a table mapping each key value to its index
------ in the table. E.g {"foo" : 4, "bar" : 30 } --> {1: "foo", 2: "bar"}
---
--- :param table : input table
---
--- :return table : the index table
------------------------------------------------------------------------------
function _makeIndexTable(table) 
	local outTable = {}
	local i = 0

	for key, _ in pairs(table) do
		outTable[i] = key
		i = i + 1
	end

	outTable["len"] = i
	return outTable
end

------------------------------------------------------------------------------
--- PUBLIC LIBRARY INTERFACE
------------------------------------------------------------------------------
return {
	getTableIndex = _getTableIndex,
	makeIndexTable = _makeIndexTable
}
