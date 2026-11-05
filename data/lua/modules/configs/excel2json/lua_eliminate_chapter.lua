-- chunkname: @modules/configs/excel2json/lua_eliminate_chapter.lua

module("modules.configs.excel2json.lua_eliminate_chapter", package.seeall)

local lua_eliminate_chapter = {}
local fields = {
	id = 1,
	name = 2,
	activityId = 3,
	map = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.eliminate_chapter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_chapter, "configList", _configList)
	rawset(lua_eliminate_chapter, "configDict", _configDict)
end

setmetatable(lua_eliminate_chapter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_chapter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_chapter, "configList", nil)
	rawset(lua_eliminate_chapter, "configDict", nil)
end

return lua_eliminate_chapter
