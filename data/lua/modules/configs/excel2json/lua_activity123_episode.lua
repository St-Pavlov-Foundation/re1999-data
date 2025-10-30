﻿-- chunkname: @modules/configs/excel2json/lua_activity123_episode.lua

module("modules.configs.excel2json.lua_activity123_episode", package.seeall)

local lua_activity123_episode = {}
local fields = {
	level = 5,
	layerName = 8,
	stagePicture = 6,
	desc = 9,
	unlockEquipIndex = 10,
	layerPicture = 7,
	episodeId = 4,
	displayMark = 11,
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
	desc = 2,
	layerName = 1
}

function lua_activity123_episode.onLoad(json)
	lua_activity123_episode.configList, lua_activity123_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_episode
