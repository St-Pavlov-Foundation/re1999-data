﻿-- chunkname: @modules/configs/excel2json/lua_copost_character_event.lua

module("modules.configs.excel2json.lua_copost_character_event", package.seeall)

local lua_copost_character_event = {}
local fields = {
	id = 1,
	eventCoordinate = 3,
	eventTextId = 4,
	chaId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_character_event.onLoad(json)
	lua_copost_character_event.configList, lua_copost_character_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_character_event
