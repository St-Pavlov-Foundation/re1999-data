-- chunkname: @modules/configs/excel2json/lua_activity244_chapter.lua

module("modules.configs.excel2json.lua_activity244_chapter", package.seeall)

local lua_activity244_chapter = {}
local fields = {
	levelType = 3,
	chapterImage = 6,
	sortIndex = 4,
	id = 1,
	chapterName = 2,
	unlock = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	chapterName = 1
}
local _configList, _configDict
local configPath = "configs.activity244_chapter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_chapter, "configList", _configList)
	rawset(lua_activity244_chapter, "configDict", _configDict)
end

setmetatable(lua_activity244_chapter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_chapter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_chapter, "configList", nil)
	rawset(lua_activity244_chapter, "configDict", nil)
end

return lua_activity244_chapter
