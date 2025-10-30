-- chunkname: @modules/configs/excel2json/lua_rouge2_path_select.lua

module("modules.configs.excel2json.lua_rouge2_path_select", package.seeall)

local lua_rouge2_path_select = {}
local fields = {
	id = 1,
	simageMapPos = 3,
	startPos = 4,
	mapRes = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_path_select.onLoad(json)
	lua_rouge2_path_select.configList, lua_rouge2_path_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_path_select
