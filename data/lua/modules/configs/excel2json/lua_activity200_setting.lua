-- chunkname: @modules/configs/excel2json/lua_activity200_setting.lua

module("modules.configs.excel2json.lua_activity200_setting", package.seeall)

local lua_activity200_setting = {}
local fields = {
	detial = 3,
	size = 2,
	activityId = 1,
	failText = 4
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {
	failText = 2,
	detial = 1
}
local _configList, _configDict
local configPath = "configs.activity200_setting_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity200_setting, "configList", _configList)
	rawset(lua_activity200_setting, "configDict", _configDict)
end

setmetatable(lua_activity200_setting, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity200_setting.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity200_setting, "configList", nil)
	rawset(lua_activity200_setting, "configDict", nil)
end

return lua_activity200_setting
