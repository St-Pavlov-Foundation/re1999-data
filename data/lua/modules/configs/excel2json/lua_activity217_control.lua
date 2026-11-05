-- chunkname: @modules/configs/excel2json/lua_activity217_control.lua

module("modules.configs.excel2json.lua_activity217_control", package.seeall)

local lua_activity217_control = {}
local fields = {
	showtype = 3,
	dailyLimit = 6,
	limit = 5,
	type = 2,
	activityId = 1,
	magnification = 4
}
local primaryKey = {
	"activityId",
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity217_control_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity217_control, "configList", _configList)
	rawset(lua_activity217_control, "configDict", _configDict)
end

setmetatable(lua_activity217_control, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity217_control.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity217_control, "configList", nil)
	rawset(lua_activity217_control, "configDict", nil)
end

return lua_activity217_control
