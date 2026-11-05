-- chunkname: @modules/configs/excel2json/lua_chapter_divide.lua

module("modules.configs.excel2json.lua_chapter_divide", package.seeall)

local lua_chapter_divide = {}
local fields = {
	resPageClosed = 5,
	name = 2,
	nameEn = 3,
	resPage = 4,
	chapterId = 6,
	storyId = 7,
	sectionId = 1
}
local primaryKey = {
	"sectionId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.chapter_divide_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_divide, "configList", _configList)
	rawset(lua_chapter_divide, "configDict", _configDict)
end

setmetatable(lua_chapter_divide, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_divide.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_divide, "configList", nil)
	rawset(lua_chapter_divide, "configDict", nil)
end

return lua_chapter_divide
