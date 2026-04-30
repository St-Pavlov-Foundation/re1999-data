-- chunkname: @modules/configs/excel2json/lua_anniversary_sign_in.lua

module("modules.configs.excel2json.lua_anniversary_sign_in", package.seeall)

local lua_anniversary_sign_in = {}
local fields = {
	content = 5,
	name = 4,
	characterId = 3,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {}

function lua_anniversary_sign_in.onLoad(json)
	lua_anniversary_sign_in.configList, lua_anniversary_sign_in.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_anniversary_sign_in
