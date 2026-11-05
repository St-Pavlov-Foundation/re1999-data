-- chunkname: @modules/configs/excel2json/lua_hero_story_plot.lua

module("modules.configs.excel2json.lua_hero_story_plot", package.seeall)

local lua_hero_story_plot = {}
local fields = {
	addControl = 8,
	name = 5,
	param = 4,
	type = 3,
	controlParam = 10,
	desc = 6,
	controlDelay = 9,
	pause = 7,
	id = 1,
	storygroup = 2,
	level = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_plot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_plot, "configList", _configList)
	rawset(lua_hero_story_plot, "configDict", _configDict)
end

setmetatable(lua_hero_story_plot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_plot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_plot, "configList", nil)
	rawset(lua_hero_story_plot, "configDict", nil)
end

return lua_hero_story_plot
