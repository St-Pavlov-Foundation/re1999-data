﻿-- chunkname: @modules/configs/excel2json/lua_fight_buff_type_id_2_scene_effect.lua

module("modules.configs.excel2json.lua_fight_buff_type_id_2_scene_effect", package.seeall)

local lua_fight_buff_type_id_2_scene_effect = {}
local fields = {
	id = 1,
	effect = 2,
	pos = 3,
	reverseX = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_buff_type_id_2_scene_effect.onLoad(json)
	lua_fight_buff_type_id_2_scene_effect.configList, lua_fight_buff_type_id_2_scene_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_type_id_2_scene_effect
