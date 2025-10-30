-- chunkname: @modules/configs/excel2json/lua_rouge2_choice.lua

module("modules.configs.excel2json.lua_rouge2_choice", package.seeall)

local lua_rouge2_choice = {}
local fields = {
	unlock = 13,
	display = 18,
	episodeId = 11,
	eventId = 2,
	randomSelect = 12,
	title = 14,
	interactiveSuccess = 17,
	desc = 15,
	descLose = 19,
	check = 8,
	initialSelect = 7,
	checkId = 10,
	exSelectNum = 6,
	interactiveLose = 20,
	thresholdDesc = 3,
	descBigSuccess = 21,
	positionParam = 4,
	selectType = 23,
	afterSelect = 9,
	descSuccess = 16,
	id = 1,
	interactiveBigSuccess = 22,
	weight = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge2_choice.onLoad(json)
	lua_rouge2_choice.configList, lua_rouge2_choice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_choice
