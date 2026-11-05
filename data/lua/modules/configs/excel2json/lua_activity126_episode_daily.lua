-- chunkname: @modules/configs/excel2json/lua_activity126_episode_daily.lua

module("modules.configs.excel2json.lua_activity126_episode_daily", package.seeall)

local lua_activity126_episode_daily = {}
local fields = {
	id = 1,
	activityId = 3,
	refreshDay = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity126_episode_daily_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity126_episode_daily, "configList", _configList)
	rawset(lua_activity126_episode_daily, "configDict", _configDict)
end

setmetatable(lua_activity126_episode_daily, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity126_episode_daily.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity126_episode_daily, "configList", nil)
	rawset(lua_activity126_episode_daily, "configDict", nil)
end

return lua_activity126_episode_daily
