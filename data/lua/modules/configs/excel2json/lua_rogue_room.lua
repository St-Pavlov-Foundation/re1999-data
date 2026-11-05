-- chunkname: @modules/configs/excel2json/lua_rogue_room.lua

module("modules.configs.excel2json.lua_rogue_room", package.seeall)

local lua_rogue_room = {}
local fields = {
	nextRoom = 6,
	name = 2,
	layer = 5,
	type = 7,
	id = 1,
	difficulty = 4,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rogue_room_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_room, "configList", _configList)
	rawset(lua_rogue_room, "configDict", _configDict)
end

setmetatable(lua_rogue_room, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_room.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_room, "configList", nil)
	rawset(lua_rogue_room, "configDict", nil)
end

return lua_rogue_room
