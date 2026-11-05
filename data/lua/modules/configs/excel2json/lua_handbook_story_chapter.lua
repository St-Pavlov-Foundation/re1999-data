-- chunkname: @modules/configs/excel2json/lua_handbook_story_chapter.lua

module("modules.configs.excel2json.lua_handbook_story_chapter", package.seeall)

local lua_handbook_story_chapter = {}
local fields = {
	nameEn = 5,
	name = 4,
	year = 6,
	type = 2,
	id = 1,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.handbook_story_chapter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_story_chapter, "configList", _configList)
	rawset(lua_handbook_story_chapter, "configDict", _configDict)
end

setmetatable(lua_handbook_story_chapter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_story_chapter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_story_chapter, "configList", nil)
	rawset(lua_handbook_story_chapter, "configDict", nil)
end

return lua_handbook_story_chapter
