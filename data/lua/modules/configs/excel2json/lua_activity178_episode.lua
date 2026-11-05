-- chunkname: @modules/configs/excel2json/lua_activity178_episode.lua

module("modules.configs.excel2json.lua_activity178_episode", package.seeall)

local lua_activity178_episode = {}
local fields = {
	reward = 12,
	name = 4,
	condition2 = 10,
	type = 3,
	target = 11,
	shortDesc = 6,
	condition = 9,
	desc = 7,
	mapId = 8,
	id = 2,
	longDesc = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	longDesc = 2,
	name = 1,
	shortDesc = 3,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.activity178_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_episode, "configList", _configList)
	rawset(lua_activity178_episode, "configDict", _configDict)
end

setmetatable(lua_activity178_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_episode, "configList", nil)
	rawset(lua_activity178_episode, "configDict", nil)
end

return lua_activity178_episode
