-- chunkname: @modules/configs/excel2json/lua_recycle_conversion.lua

module("modules.configs.excel2json.lua_recycle_conversion", package.seeall)

local lua_recycle_conversion = {}
local fields = {
	recycleId = 1,
	recycleType = 2,
	conversionId = 3,
	conversionType = 4
}
local primaryKey = {
	"recycleId"
}
local mlStringKey = {}

function lua_recycle_conversion.onLoad(json)
	lua_recycle_conversion.configList, lua_recycle_conversion.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_recycle_conversion
