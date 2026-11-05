-- chunkname: @modules/configs/excel2json/lua_track_coin_string.lua

module("modules.configs.excel2json.lua_track_coin_string", package.seeall)

local lua_track_coin_string = {}
local fields = {
	elementId = 3,
	space = 5,
	point = 4,
	traceId = 1,
	isOn = 6,
	coinStringId = 2
}
local primaryKey = {
	"traceId",
	"coinStringId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.track_coin_string_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_track_coin_string, "configList", _configList)
	rawset(lua_track_coin_string, "configDict", _configDict)
end

setmetatable(lua_track_coin_string, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_track_coin_string.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_track_coin_string, "configList", nil)
	rawset(lua_track_coin_string, "configDict", nil)
end

return lua_track_coin_string
