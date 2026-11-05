-- chunkname: @modules/configs/excel2json/lua_activity104_episode.lua

module("modules.configs.excel2json.lua_activity104_episode", package.seeall)

local lua_activity104_episode = {}
local fields = {
	level = 8,
	stagePicture = 7,
	stageNameEn = 6,
	episodeId = 3,
	unlockEquipIndex = 9,
	afterStoryId = 11,
	desc = 12,
	stageName = 5,
	firstPassEquipId = 10,
	stage = 4,
	activityId = 1,
	layer = 2
}
local primaryKey = {
	"activityId",
	"layer"
}
local mlStringKey = {
	desc = 2,
	stageName = 1
}
local _configList, _configDict
local configPath = "configs.activity104_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_episode, "configList", _configList)
	rawset(lua_activity104_episode, "configDict", _configDict)
end

setmetatable(lua_activity104_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_episode, "configList", nil)
	rawset(lua_activity104_episode, "configDict", nil)
end

return lua_activity104_episode
