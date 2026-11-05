-- chunkname: @modules/configs/excel2json/lua_handbook_story_group.lua

module("modules.configs.excel2json.lua_handbook_story_group", package.seeall)

local lua_handbook_story_group = {}
local fields = {
	nameEn = 6,
	name = 5,
	time = 8,
	date = 7,
	episodeId = 4,
	image = 13,
	fragmentIdList = 12,
	storyChapterId = 3,
	storyIdList = 10,
	levelIdDict = 11,
	year = 9,
	id = 1,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.handbook_story_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_story_group, "configList", _configList)
	rawset(lua_handbook_story_group, "configDict", _configDict)
end

setmetatable(lua_handbook_story_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_story_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_story_group, "configList", nil)
	rawset(lua_handbook_story_group, "configDict", nil)
end

return lua_handbook_story_group
