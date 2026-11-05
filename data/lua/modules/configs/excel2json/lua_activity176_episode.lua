-- chunkname: @modules/configs/excel2json/lua_activity176_episode.lua

module("modules.configs.excel2json.lua_activity176_episode", package.seeall)

local lua_activity176_episode = {}
local fields = {
	elementId = 3,
	activityId = 1,
	uiTemplate = 5,
	id = 2,
	target = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	target = 1
}
local _configList, _configDict
local configPath = "configs.activity176_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity176_episode, "configList", _configList)
	rawset(lua_activity176_episode, "configDict", _configDict)
end

setmetatable(lua_activity176_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity176_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity176_episode, "configList", nil)
	rawset(lua_activity176_episode, "configDict", nil)
end

return lua_activity176_episode
