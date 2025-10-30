-- chunkname: @modules/configs/excel2json/lua_rouge2_middle_layer.lua

module("modules.configs.excel2json.lua_rouge2_middle_layer", package.seeall)

local lua_rouge2_middle_layer = {}
local fields = {
	path = 10,
	name = 2,
	dayOrNight = 11,
	empty = 12,
	pointPos = 6,
	leavePosUnlock = 9,
	pathPointPos = 7,
	pathSelect = 4,
	leavePos = 8,
	id = 1,
	nextLayer = 3,
	mapRes = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge2_middle_layer.onLoad(json)
	lua_rouge2_middle_layer.configList, lua_rouge2_middle_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_middle_layer
