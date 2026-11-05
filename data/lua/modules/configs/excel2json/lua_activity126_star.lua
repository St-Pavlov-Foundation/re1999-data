-- chunkname: @modules/configs/excel2json/lua_activity126_star.lua

module("modules.configs.excel2json.lua_activity126_star", package.seeall)

local lua_activity126_star = {}
local fields = {
	pos = 5,
	tip = 4,
	num = 1,
	activityId = 2,
	bonus = 3
}
local primaryKey = {
	"num",
	"activityId"
}
local mlStringKey = {
	tip = 1
}
local _configList, _configDict
local configPath = "configs.activity126_star_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity126_star, "configList", _configList)
	rawset(lua_activity126_star, "configDict", _configDict)
end

setmetatable(lua_activity126_star, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity126_star.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity126_star, "configList", nil)
	rawset(lua_activity126_star, "configDict", nil)
end

return lua_activity126_star
