-- chunkname: @modules/configs/excel2json/lua_activity144_const.lua

module("modules.configs.excel2json.lua_activity144_const", package.seeall)

local lua_activity144_const = {}
local fields = {
	activityId = 1,
	value1 = 3,
	id = 2,
	value3 = 5,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	value3 = 1
}
local _configList, _configDict
local configPath = "configs.activity144_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_const, "configList", _configList)
	rawset(lua_activity144_const, "configDict", _configDict)
end

setmetatable(lua_activity144_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_const, "configList", nil)
	rawset(lua_activity144_const, "configDict", nil)
end

return lua_activity144_const
