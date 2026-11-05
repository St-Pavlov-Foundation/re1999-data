-- chunkname: @modules/configs/excel2json/lua_activity212_const.lua

module("modules.configs.excel2json.lua_activity212_const", package.seeall)

local lua_activity212_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity212_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity212_const, "configList", _configList)
	rawset(lua_activity212_const, "configDict", _configDict)
end

setmetatable(lua_activity212_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity212_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity212_const, "configList", nil)
	rawset(lua_activity212_const, "configDict", nil)
end

return lua_activity212_const
