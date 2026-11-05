-- chunkname: @modules/configs/excel2json/lua_activity142_chapter.lua

module("modules.configs.excel2json.lua_activity142_chapter", package.seeall)

local lua_activity142_chapter = {}
local fields = {
	selectSprite = 6,
	name = 3,
	lockSprite = 7,
	txtColor = 4,
	id = 2,
	normalSprite = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity142_chapter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity142_chapter, "configList", _configList)
	rawset(lua_activity142_chapter, "configDict", _configDict)
end

setmetatable(lua_activity142_chapter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity142_chapter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity142_chapter, "configList", nil)
	rawset(lua_activity142_chapter, "configDict", nil)
end

return lua_activity142_chapter
