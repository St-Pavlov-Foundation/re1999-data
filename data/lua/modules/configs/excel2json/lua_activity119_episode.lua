-- chunkname: @modules/configs/excel2json/lua_activity119_episode.lua

module("modules.configs.excel2json.lua_activity119_episode", package.seeall)

local lua_activity119_episode = {}
local fields = {
	openDay = 5,
	name = 3,
	tabId = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	des = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity119_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity119_episode, "configList", _configList)
	rawset(lua_activity119_episode, "configDict", _configDict)
end

setmetatable(lua_activity119_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity119_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity119_episode, "configList", nil)
	rawset(lua_activity119_episode, "configDict", nil)
end

return lua_activity119_episode
