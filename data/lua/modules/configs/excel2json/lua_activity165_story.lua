-- chunkname: @modules/configs/excel2json/lua_activity165_story.lua

module("modules.configs.excel2json.lua_activity165_story", package.seeall)

local lua_activity165_story = {}
local fields = {
	storyId = 2,
	unlockElementIds2 = 7,
	firstUnlockElementCd2 = 8,
	preElementId1 = 3,
	firstUnlockElementCd1 = 5,
	unlockElementIds1 = 4,
	pic = 11,
	name = 10,
	firstStepId = 9,
	preElementId2 = 6,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"storyId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity165_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity165_story, "configList", _configList)
	rawset(lua_activity165_story, "configDict", _configDict)
end

setmetatable(lua_activity165_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity165_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity165_story, "configList", nil)
	rawset(lua_activity165_story, "configDict", nil)
end

return lua_activity165_story
