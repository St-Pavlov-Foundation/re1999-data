-- chunkname: @modules/configs/excel2json/lua_hero_story_plot_group.lua

module("modules.configs.excel2json.lua_hero_story_plot_group", package.seeall)

local lua_hero_story_plot_group = {}
local fields = {
	storyPic = 9,
	branch = 11,
	storyNameEn = 4,
	storyId = 2,
	preId = 10,
	time = 5,
	date = 12,
	place = 6,
	roleName = 8,
	weather = 7,
	storyName = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	roleName = 3,
	place = 2,
	storyName = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_plot_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_plot_group, "configList", _configList)
	rawset(lua_hero_story_plot_group, "configDict", _configDict)
end

setmetatable(lua_hero_story_plot_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_plot_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_plot_group, "configList", nil)
	rawset(lua_hero_story_plot_group, "configDict", nil)
end

return lua_hero_story_plot_group
