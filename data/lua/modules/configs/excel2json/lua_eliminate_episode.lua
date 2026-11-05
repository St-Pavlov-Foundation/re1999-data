-- chunkname: @modules/configs/excel2json/lua_eliminate_episode.lua

module("modules.configs.excel2json.lua_eliminate_episode", package.seeall)

local lua_eliminate_episode = {}
local fields = {
	eliminateLevelId = 7,
	name = 2,
	chapterId = 5,
	preEpisode = 6,
	dialogueId = 9,
	posIndex = 4,
	levelPosition = 3,
	warChessId = 8,
	id = 1,
	aniPos = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.eliminate_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_episode, "configList", _configList)
	rawset(lua_eliminate_episode, "configDict", _configDict)
end

setmetatable(lua_eliminate_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_episode, "configList", nil)
	rawset(lua_eliminate_episode, "configDict", nil)
end

return lua_eliminate_episode
