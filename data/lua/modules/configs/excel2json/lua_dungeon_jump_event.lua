-- chunkname: @modules/configs/excel2json/lua_dungeon_jump_event.lua

module("modules.configs.excel2json.lua_dungeon_jump_event", package.seeall)

local lua_dungeon_jump_event = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.dungeon_jump_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dungeon_jump_event, "configList", _configList)
	rawset(lua_dungeon_jump_event, "configDict", _configDict)
end

setmetatable(lua_dungeon_jump_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dungeon_jump_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dungeon_jump_event, "configList", nil)
	rawset(lua_dungeon_jump_event, "configDict", nil)
end

return lua_dungeon_jump_event
