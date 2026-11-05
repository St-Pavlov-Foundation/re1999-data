-- chunkname: @modules/configs/excel2json/lua_chapter_map_hole.lua

module("modules.configs.excel2json.lua_chapter_map_hole", package.seeall)

local lua_chapter_map_hole = {}
local fields = {
	param = 3,
	mapId = 1,
	sort = 2
}
local primaryKey = {
	"mapId",
	"sort"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.chapter_map_hole_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_map_hole, "configList", _configList)
	rawset(lua_chapter_map_hole, "configDict", _configDict)
end

setmetatable(lua_chapter_map_hole, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_map_hole.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_map_hole, "configList", nil)
	rawset(lua_chapter_map_hole, "configDict", nil)
end

return lua_chapter_map_hole
