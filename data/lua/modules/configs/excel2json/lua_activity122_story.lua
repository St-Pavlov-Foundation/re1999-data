-- chunkname: @modules/configs/excel2json/lua_activity122_story.lua

module("modules.configs.excel2json.lua_activity122_story", package.seeall)

local lua_activity122_story = {}
local fields = {
	bgPath = 9,
	name = 3,
	needbg = 8,
	nameen = 4,
	episodeId = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	order = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity122_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity122_story, "configList", _configList)
	rawset(lua_activity122_story, "configDict", _configDict)
end

setmetatable(lua_activity122_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity122_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity122_story, "configList", nil)
	rawset(lua_activity122_story, "configDict", nil)
end

return lua_activity122_story
