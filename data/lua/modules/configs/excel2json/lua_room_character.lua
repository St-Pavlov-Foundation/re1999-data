-- chunkname: @modules/configs/excel2json/lua_room_character.lua

module("modules.configs.excel2json.lua_room_character", package.seeall)

local lua_room_character = {}
local fields = {
	shadow = 8,
	moveSpeed = 6,
	zeroMix = 7,
	skinId = 1,
	cameraAnimPath = 9,
	specialIdle = 2,
	effectPath = 10,
	waterDistance = 11,
	specialRate = 3,
	roleVoice = 12,
	hideFootprint = 13,
	moveRate = 5,
	moveInterval = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character, "configList", _configList)
	rawset(lua_room_character, "configDict", _configDict)
end

setmetatable(lua_room_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character, "configList", nil)
	rawset(lua_room_character, "configDict", nil)
end

return lua_room_character
