-- chunkname: @modules/configs/excel2json/lua_activity234_control.lua

module("modules.configs.excel2json.lua_activity234_control", package.seeall)

local lua_activity234_control = {}
local fields = {
	magnificationCount = 3,
	magnificationRate = 4,
	singleScoreLimit = 5,
	activityId = 1,
	times = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity234_control_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity234_control, "configList", _configList)
	rawset(lua_activity234_control, "configDict", _configDict)
end

setmetatable(lua_activity234_control, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity234_control.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity234_control, "configList", nil)
	rawset(lua_activity234_control, "configDict", nil)
end

return lua_activity234_control
