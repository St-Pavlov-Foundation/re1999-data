-- chunkname: @modules/configs/excel2json/lua_tower_compose_episode.lua

module("modules.configs.excel2json.lua_tower_compose_episode", package.seeall)

local lua_tower_compose_episode = {}
local fields = {
	stageId = 3,
	name = 6,
	layerId = 2,
	episodeId = 8,
	unlockModIds = 9,
	nextLayerId = 4,
	unlock = 5,
	themeId = 1,
	plane = 7
}
local primaryKey = {
	"themeId",
	"layerId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_compose_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_episode, "configList", _configList)
	rawset(lua_tower_compose_episode, "configDict", _configDict)
end

setmetatable(lua_tower_compose_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_episode, "configList", nil)
	rawset(lua_tower_compose_episode, "configDict", nil)
end

return lua_tower_compose_episode
