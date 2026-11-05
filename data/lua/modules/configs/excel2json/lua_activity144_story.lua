-- chunkname: @modules/configs/excel2json/lua_activity144_story.lua

module("modules.configs.excel2json.lua_activity144_story", package.seeall)

local lua_activity144_story = {}
local fields = {
	titleen = 5,
	name = 3,
	order = 8,
	nameen = 4,
	id = 2,
	icon = 7,
	activityId = 1,
	episodeId = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity144_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_story, "configList", _configList)
	rawset(lua_activity144_story, "configDict", _configDict)
end

setmetatable(lua_activity144_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_story, "configList", nil)
	rawset(lua_activity144_story, "configDict", nil)
end

return lua_activity144_story
