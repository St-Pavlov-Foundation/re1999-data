-- chunkname: @modules/configs/excel2json/lua_survival_rain.lua

module("modules.configs.excel2json.lua_survival_rain", package.seeall)

local lua_survival_rain = {}
local fields = {
	id = 1,
	name = 3,
	rainDesc = 4,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	rainDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_rain_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_rain, "configList", _configList)
	rawset(lua_survival_rain, "configDict", _configDict)
end

setmetatable(lua_survival_rain, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_rain.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_rain, "configList", nil)
	rawset(lua_survival_rain, "configDict", nil)
end

return lua_survival_rain
