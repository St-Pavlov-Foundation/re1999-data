-- chunkname: @modules/configs/excel2json/lua_room_level.lua

module("modules.configs.excel2json.lua_room_level", package.seeall)

local lua_room_level = {}
local fields = {
	cost = 2,
	needBlockCount = 3,
	characterLimit = 5,
	needCost = 6,
	maxBlockCount = 4,
	needEpisode = 7,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_level, "configList", _configList)
	rawset(lua_room_level, "configDict", _configDict)
end

setmetatable(lua_room_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_level, "configList", nil)
	rawset(lua_room_level, "configDict", nil)
end

return lua_room_level
