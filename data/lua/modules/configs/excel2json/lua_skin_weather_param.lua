-- chunkname: @modules/configs/excel2json/lua_skin_weather_param.lua

module("modules.configs.excel2json.lua_skin_weather_param", package.seeall)

local lua_skin_weather_param = {}
local fields = {
	emissionColor3 = 12,
	bloomColor3 = 4,
	mainColor1 = 6,
	mainColor2 = 7,
	emissionColor1 = 10,
	bloomColor1 = 2,
	emissionColor4 = 13,
	bloomColor4 = 5,
	mainColor3 = 8,
	emissionColor2 = 11,
	bloomColor2 = 3,
	id = 1,
	mainColor4 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_weather_param_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_weather_param, "configList", _configList)
	rawset(lua_skin_weather_param, "configDict", _configDict)
end

setmetatable(lua_skin_weather_param, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_weather_param.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_weather_param, "configList", nil)
	rawset(lua_skin_weather_param, "configDict", nil)
end

return lua_skin_weather_param
