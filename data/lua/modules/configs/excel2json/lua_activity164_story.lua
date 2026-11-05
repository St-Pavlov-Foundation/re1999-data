-- chunkname: @modules/configs/excel2json/lua_activity164_story.lua

module("modules.configs.excel2json.lua_activity164_story", package.seeall)

local lua_activity164_story = {}
local fields = {
	bgPath = 9,
	name = 5,
	needbg = 8,
	nameen = 6,
	episodeId = 2,
	id = 4,
	icon = 7,
	activityId = 1,
	order = 3
}
local primaryKey = {
	"activityId",
	"episodeId",
	"order"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity164_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity164_story, "configList", _configList)
	rawset(lua_activity164_story, "configDict", _configDict)
end

setmetatable(lua_activity164_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity164_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity164_story, "configList", nil)
	rawset(lua_activity164_story, "configDict", nil)
end

return lua_activity164_story
