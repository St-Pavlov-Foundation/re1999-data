-- chunkname: @modules/configs/excel2json/lua_activity104_story.lua

module("modules.configs.excel2json.lua_activity104_story", package.seeall)

local lua_activity104_story = {}
local fields = {
	id = 1,
	picture = 5,
	subTitle = 6,
	storyId = 2,
	condition = 9,
	title = 3,
	content = 8,
	titleEn = 4,
	subContent = 7
}
local primaryKey = {
	"id",
	"storyId"
}
local mlStringKey = {
	subTitle = 3,
	titleEn = 2,
	subContent = 4,
	title = 1,
	content = 5
}
local _configList, _configDict
local configPath = "configs.activity104_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_story, "configList", _configList)
	rawset(lua_activity104_story, "configDict", _configDict)
end

setmetatable(lua_activity104_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_story, "configList", nil)
	rawset(lua_activity104_story, "configDict", nil)
end

return lua_activity104_story
