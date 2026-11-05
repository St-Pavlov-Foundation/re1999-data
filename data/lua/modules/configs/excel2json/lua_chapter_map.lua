-- chunkname: @modules/configs/excel2json/lua_chapter_map.lua

module("modules.configs.excel2json.lua_chapter_map", package.seeall)

local lua_chapter_map = {}
local fields = {
	areaAudio = 8,
	mapIdGroup = 10,
	unlockCondition = 3,
	chapterId = 2,
	mapState = 9,
	initPos = 6,
	effectAudio = 7,
	desc = 5,
	res = 4,
	playEffect = 11,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.chapter_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_map, "configList", _configList)
	rawset(lua_chapter_map, "configDict", _configDict)
end

setmetatable(lua_chapter_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_map, "configList", nil)
	rawset(lua_chapter_map, "configDict", nil)
end

return lua_chapter_map
