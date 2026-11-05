-- chunkname: @modules/configs/excel2json/lua_single_mode_episode.lua

module("modules.configs.excel2json.lua_single_mode_episode", package.seeall)

local lua_single_mode_episode = {}
local fields = {
	openDay = 3,
	episodeId2Level = 4,
	activityId = 2,
	chapterId = 1
}
local primaryKey = {
	"chapterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.single_mode_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_single_mode_episode, "configList", _configList)
	rawset(lua_single_mode_episode, "configDict", _configDict)
end

setmetatable(lua_single_mode_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_single_mode_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_single_mode_episode, "configList", nil)
	rawset(lua_single_mode_episode, "configDict", nil)
end

return lua_single_mode_episode
