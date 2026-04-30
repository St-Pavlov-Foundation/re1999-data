-- chunkname: @modules/configs/excel2json/lua_sodache_handbook.lua

module("modules.configs.excel2json.lua_sodache_handbook", package.seeall)

local lua_sodache_handbook = {}
local fields = {
	tab1 = 3,
	monsterDesc = 5,
	tab2 = 4,
	id = 1,
	eleId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	monsterDesc = 1
}

function lua_sodache_handbook.onLoad(json)
	lua_sodache_handbook.configList, lua_sodache_handbook.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_handbook
