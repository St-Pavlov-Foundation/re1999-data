-- chunkname: @modules/configs/excel2json/lua_activity148.lua

module("modules.configs.excel2json.lua_activity148", package.seeall)

local lua_activity148 = {}
local fields = {
	skillSmallIcon = 8,
	skillId = 6,
	cost = 5,
	type = 3,
	skillAttrDesc = 9,
	attrs = 7,
	id = 1,
	activityId = 2,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillAttrDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity148_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity148, "configList", _configList)
	rawset(lua_activity148, "configDict", _configDict)
end

setmetatable(lua_activity148, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity148.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity148, "configList", nil)
	rawset(lua_activity148, "configDict", nil)
end

return lua_activity148
