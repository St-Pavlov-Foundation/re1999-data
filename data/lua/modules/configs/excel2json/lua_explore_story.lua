-- chunkname: @modules/configs/excel2json/lua_explore_story.lua

module("modules.configs.excel2json.lua_explore_story", package.seeall)

local lua_explore_story = {}
local fields = {
	type = 6,
	res = 5,
	chapterId = 1,
	id = 2,
	title = 3,
	content = 7,
	desc = 4
}
local primaryKey = {
	"chapterId",
	"id"
}
local mlStringKey = {
	title = 1,
	content = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.explore_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_story, "configList", _configList)
	rawset(lua_explore_story, "configDict", _configDict)
end

setmetatable(lua_explore_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_story, "configList", nil)
	rawset(lua_explore_story, "configDict", nil)
end

return lua_explore_story
