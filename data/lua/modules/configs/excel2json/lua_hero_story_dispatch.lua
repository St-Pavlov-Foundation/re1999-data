-- chunkname: @modules/configs/excel2json/lua_hero_story_dispatch.lua

module("modules.configs.excel2json.lua_hero_story_dispatch", package.seeall)

local lua_hero_story_dispatch = {}
local fields = {
	scoreReward = 9,
	name = 4,
	count = 8,
	type = 2,
	time = 10,
	effect = 12,
	effectDesc = 13,
	desc = 5,
	unlockEpisodeId = 14,
	talkIds = 15,
	heroStoryId = 3,
	consume = 7,
	id = 1,
	effectCondition = 11,
	completeDesc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 4,
	name = 1,
	completeDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.hero_story_dispatch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_dispatch, "configList", _configList)
	rawset(lua_hero_story_dispatch, "configDict", _configDict)
end

setmetatable(lua_hero_story_dispatch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_dispatch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_dispatch, "configList", nil)
	rawset(lua_hero_story_dispatch, "configDict", nil)
end

return lua_hero_story_dispatch
