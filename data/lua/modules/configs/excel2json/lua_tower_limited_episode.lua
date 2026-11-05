-- chunkname: @modules/configs/excel2json/lua_tower_limited_episode.lua

module("modules.configs.excel2json.lua_tower_limited_episode", package.seeall)

local lua_tower_limited_episode = {}
local fields = {
	entrance = 5,
	season = 3,
	layerId = 1,
	difficulty = 2,
	episodeId = 4
}
local primaryKey = {
	"layerId",
	"difficulty"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_limited_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_limited_episode, "configList", _configList)
	rawset(lua_tower_limited_episode, "configDict", _configDict)
end

setmetatable(lua_tower_limited_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_limited_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_limited_episode, "configList", nil)
	rawset(lua_tower_limited_episode, "configDict", nil)
end

return lua_tower_limited_episode
