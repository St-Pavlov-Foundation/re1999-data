-- chunkname: @modules/configs/excel2json/lua_college_story_dialog.lua

module("modules.configs.excel2json.lua_college_story_dialog", package.seeall)

local lua_college_story_dialog = {}
local fields = {
	picture = 3,
	name = 5,
	stepId = 2,
	type = 7,
	id = 1,
	position = 4,
	desc = 6
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_college_story_dialog.onLoad(json)
	lua_college_story_dialog.configList, lua_college_story_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_story_dialog
