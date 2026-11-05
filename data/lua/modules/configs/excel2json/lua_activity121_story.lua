-- chunkname: @modules/configs/excel2json/lua_activity121_story.lua

module("modules.configs.excel2json.lua_activity121_story", package.seeall)

local lua_activity121_story = {}
local fields = {
	noteIds = 6,
	name = 3,
	clueIds = 5,
	bonus = 7,
	id = 2,
	icon = 8,
	activityId = 1,
	episodeId = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity121_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity121_story, "configList", _configList)
	rawset(lua_activity121_story, "configDict", _configDict)
end

setmetatable(lua_activity121_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity121_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity121_story, "configList", nil)
	rawset(lua_activity121_story, "configDict", nil)
end

return lua_activity121_story
