﻿-- chunkname: @modules/configs/excel2json/lua_rouge2_illustration_list.lua

module("modules.configs.excel2json.lua_rouge2_illustration_list", package.seeall)

local lua_rouge2_illustration_list = {}
local fields = {
	type = 4,
	name = 3,
	nameEn = 5,
	fullImage = 8,
	eventId = 9,
	image = 7,
	desc = 6,
	id = 1,
	eventAttribute = 10,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge2_illustration_list.onLoad(json)
	lua_rouge2_illustration_list.configList, lua_rouge2_illustration_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_illustration_list
