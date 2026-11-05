-- chunkname: @modules/configs/excel2json/lua_hero_story_task.lua

module("modules.configs.excel2json.lua_hero_story_task", package.seeall)

local lua_hero_story_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	storyId = 2,
	listenerType = 7,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	activityId = 10,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.hero_story_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_task, "configList", _configList)
	rawset(lua_hero_story_task, "configDict", _configDict)
end

setmetatable(lua_hero_story_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_task, "configList", nil)
	rawset(lua_hero_story_task, "configDict", nil)
end

return lua_hero_story_task
