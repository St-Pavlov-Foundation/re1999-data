-- chunkname: @modules/configs/excel2json/lua_tower_boss_episode.lua

module("modules.configs.excel2json.lua_tower_boss_episode", package.seeall)

local lua_tower_boss_episode = {}
local fields = {
	layerId = 2,
	firstReward = 7,
	bossLevel = 6,
	preLayerId = 3,
	episodeId = 5,
	openRound = 4,
	towerId = 1
}
local primaryKey = {
	"towerId",
	"layerId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_boss_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_boss_episode, "configList", _configList)
	rawset(lua_tower_boss_episode, "configDict", _configDict)
end

setmetatable(lua_tower_boss_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_boss_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_boss_episode, "configList", nil)
	rawset(lua_tower_boss_episode, "configDict", nil)
end

return lua_tower_boss_episode
