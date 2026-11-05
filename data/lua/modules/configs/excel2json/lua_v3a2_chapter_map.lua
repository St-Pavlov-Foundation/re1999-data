-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_map.lua

module("modules.configs.excel2json.lua_v3a2_chapter_map", package.seeall)

local lua_v3a2_chapter_map = {}
local fields = {
	descRotation = 6,
	titlePos = 5,
	descOffset = 8,
	isShow = 9,
	descPos = 7,
	titleRotation = 4,
	id = 1,
	position = 3,
	locationDesc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	locationDesc = 1
}
local _configList, _configDict
local configPath = "configs.v3a2_chapter_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a2_chapter_map, "configList", _configList)
	rawset(lua_v3a2_chapter_map, "configDict", _configDict)
end

setmetatable(lua_v3a2_chapter_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a2_chapter_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a2_chapter_map, "configList", nil)
	rawset(lua_v3a2_chapter_map, "configDict", nil)
end

return lua_v3a2_chapter_map
