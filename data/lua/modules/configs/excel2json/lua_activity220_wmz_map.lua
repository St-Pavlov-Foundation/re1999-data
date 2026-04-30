-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map.lua

module("modules.configs.excel2json.lua_activity220_wmz_map", package.seeall)

local lua_activity220_wmz_map = {}
local fields = {
	maxEnergy = 4,
	zoneId4 = 8,
	zoneId3 = 7,
	mapSizeX = 2,
	id = 1,
	mapSizeY = 3,
	zoneId2 = 6,
	zoneId1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_wmz_map.onLoad(json)
	lua_activity220_wmz_map.configList, lua_activity220_wmz_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_wmz_map
