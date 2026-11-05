-- chunkname: @modules/configs/excel2json/lua_udimo_lock_mode_setting.lua

module("modules.configs.excel2json.lua_udimo_lock_mode_setting", package.seeall)

local lua_udimo_lock_mode_setting = {}
local fields = {
	id = 1,
	name = 2,
	isDefault = 4,
	waitTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_lock_mode_setting_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_lock_mode_setting, "configList", _configList)
	rawset(lua_udimo_lock_mode_setting, "configDict", _configDict)
end

setmetatable(lua_udimo_lock_mode_setting, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_lock_mode_setting.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_lock_mode_setting, "configList", nil)
	rawset(lua_udimo_lock_mode_setting, "configDict", nil)
end

return lua_udimo_lock_mode_setting
