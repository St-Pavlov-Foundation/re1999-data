-- chunkname: @modules/configs/excel2json/lua_dungeon_maze_v3a7_event.lua

module("modules.configs.excel2json.lua_dungeon_maze_v3a7_event", package.seeall)

local lua_dungeon_maze_v3a7_event = {}
local fields = {
	type = 2,
	desc = 3,
	evenid = 1
}
local primaryKey = {
	"evenid"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.dungeon_maze_v3a7_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dungeon_maze_v3a7_event, "configList", _configList)
	rawset(lua_dungeon_maze_v3a7_event, "configDict", _configDict)
end

setmetatable(lua_dungeon_maze_v3a7_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dungeon_maze_v3a7_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dungeon_maze_v3a7_event, "configList", nil)
	rawset(lua_dungeon_maze_v3a7_event, "configDict", nil)
end

return lua_dungeon_maze_v3a7_event
