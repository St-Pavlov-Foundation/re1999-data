-- chunkname: @modules/configs/excel2json/lua_udimo_background.lua

module("modules.configs.excel2json.lua_udimo_background", package.seeall)

local lua_udimo_background = {}
local fields = {
	id = 1,
	name = 2,
	airPoints = 7,
	defaultUse = 5,
	defaultWeather = 10,
	bgm = 9,
	cameraMoveRange = 8,
	img = 3,
	isDefault = 4,
	sceneLevel = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.udimo_background_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_background, "configList", _configList)
	rawset(lua_udimo_background, "configDict", _configDict)
end

setmetatable(lua_udimo_background, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_background.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_background, "configList", nil)
	rawset(lua_udimo_background, "configDict", nil)
end

return lua_udimo_background
