-- chunkname: @modules/configs/excel2json/lua_dungeon_maze_v3a7.lua

module("modules.configs.excel2json.lua_dungeon_maze_v3a7", package.seeall)

local lua_dungeon_maze_v3a7 = {}
local fields = {
	dialogid = 5,
	celltype = 3,
	id = 1,
	cellId = 2,
	evenid = 4
}
local primaryKey = {
	"id",
	"cellId"
}
local mlStringKey = {
	dialogid = 1
}
local _configList, _configDict
local configPath = "configs.dungeon_maze_v3a7_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dungeon_maze_v3a7, "configList", _configList)
	rawset(lua_dungeon_maze_v3a7, "configDict", _configDict)
end

setmetatable(lua_dungeon_maze_v3a7, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dungeon_maze_v3a7.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dungeon_maze_v3a7, "configList", nil)
	rawset(lua_dungeon_maze_v3a7, "configDict", nil)
end

return lua_dungeon_maze_v3a7
