-- chunkname: @modules/configs/excel2json/lua_activity126_horoscope.lua

module("modules.configs.excel2json.lua_activity126_horoscope", package.seeall)

local lua_activity126_horoscope = {}
local fields = {
	desc = 4,
	resultIcon = 5,
	id = 1,
	activityId = 2,
	bonus = 3
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity126_horoscope_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity126_horoscope, "configList", _configList)
	rawset(lua_activity126_horoscope, "configDict", _configDict)
end

setmetatable(lua_activity126_horoscope, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity126_horoscope.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity126_horoscope, "configList", nil)
	rawset(lua_activity126_horoscope, "configDict", nil)
end

return lua_activity126_horoscope
