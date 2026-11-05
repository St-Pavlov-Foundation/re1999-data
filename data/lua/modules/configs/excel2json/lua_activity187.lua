-- chunkname: @modules/configs/excel2json/lua_activity187.lua

module("modules.configs.excel2json.lua_activity187", package.seeall)

local lua_activity187 = {}
local fields = {
	finishGameCount = 2,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"finishGameCount"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity187_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity187, "configList", _configList)
	rawset(lua_activity187, "configDict", _configDict)
end

setmetatable(lua_activity187, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity187.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity187, "configList", nil)
	rawset(lua_activity187, "configDict", nil)
end

return lua_activity187
