-- chunkname: @modules/configs/excel2json/lua_room_atmosphere.lua

module("modules.configs.excel2json.lua_room_atmosphere", package.seeall)

local lua_room_atmosphere = {}
local fields = {
	effectSequence = 3,
	openTime = 6,
	buildingId = 2,
	cdtimes = 9,
	residentEffect = 4,
	triggerType = 8,
	cyclesTimes = 5,
	id = 1,
	durationDay = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_atmosphere_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_atmosphere, "configList", _configList)
	rawset(lua_room_atmosphere, "configDict", _configDict)
end

setmetatable(lua_room_atmosphere, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_atmosphere.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_atmosphere, "configList", nil)
	rawset(lua_room_atmosphere, "configDict", nil)
end

return lua_room_atmosphere
