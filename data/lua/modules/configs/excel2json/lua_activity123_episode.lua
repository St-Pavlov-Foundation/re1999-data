-- chunkname: @modules/configs/excel2json/lua_activity123_episode.lua

module("modules.configs.excel2json.lua_activity123_episode", package.seeall)

local lua_activity123_episode = {}
local fields = {
	level = 5,
	layerName = 8,
	stagePicture = 6,
	desc = 9,
	recommendInfo = 10,
	layerPicture = 7,
	usableEquip = 11,
	episodeId = 4,
	displayMark = 14,
	unlockEquipIndex = 13,
	gottenEquip = 12,
	stage = 2,
	activityId = 1,
	layer = 3
}
local primaryKey = {
	"activityId",
	"stage",
	"layer"
}
local mlStringKey = {
	recommendInfo = 3,
	layerName = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity123_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_episode, "configList", _configList)
	rawset(lua_activity123_episode, "configDict", _configDict)
end

setmetatable(lua_activity123_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_episode, "configList", nil)
	rawset(lua_activity123_episode, "configDict", nil)
end

return lua_activity123_episode
