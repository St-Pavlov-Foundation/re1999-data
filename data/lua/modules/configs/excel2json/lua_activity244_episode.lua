-- chunkname: @modules/configs/excel2json/lua_activity244_episode.lua

module("modules.configs.excel2json.lua_activity244_episode", package.seeall)

local lua_activity244_episode = {}
local fields = {
	episodeImage = 8,
	firstBonus = 6,
	recCareer = 9,
	chapterId = 2,
	levelName = 3,
	preEpisode = 4,
	matchLevelId = 5,
	isHard = 10,
	id = 1,
	bonus = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	levelName = 1
}
local _configList, _configDict
local configPath = "configs.activity244_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_episode, "configList", _configList)
	rawset(lua_activity244_episode, "configDict", _configDict)
end

setmetatable(lua_activity244_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_episode, "configList", nil)
	rawset(lua_activity244_episode, "configDict", nil)
end

return lua_activity244_episode
