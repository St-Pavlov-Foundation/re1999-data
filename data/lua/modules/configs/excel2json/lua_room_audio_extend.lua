-- chunkname: @modules/configs/excel2json/lua_room_audio_extend.lua

module("modules.configs.excel2json.lua_room_audio_extend", package.seeall)

local lua_room_audio_extend = {}
local fields = {
	audioId = 2,
	rtpcValue = 6,
	rtpc = 5,
	switchGroup = 3,
	id = 1,
	switchState = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_audio_extend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_audio_extend, "configList", _configList)
	rawset(lua_room_audio_extend, "configDict", _configDict)
end

setmetatable(lua_room_audio_extend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_audio_extend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_audio_extend, "configList", nil)
	rawset(lua_room_audio_extend, "configDict", nil)
end

return lua_room_audio_extend
