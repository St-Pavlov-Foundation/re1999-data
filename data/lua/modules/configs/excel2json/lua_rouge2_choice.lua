-- chunkname: @modules/configs/excel2json/lua_rouge2_choice.lua

module("modules.configs.excel2json.lua_rouge2_choice", package.seeall)

local lua_rouge2_choice = {}
local fields = {
	unlock = 13,
	display = 19,
	episodeId = 11,
	eventId = 2,
	randomSelect = 12,
	title = 15,
	interactiveSuccess = 18,
	desc = 16,
	descLose = 20,
	check = 8,
	initialSelect = 7,
	checkId = 10,
	exSelectNum = 6,
	interactiveLose = 21,
	thresholdDesc = 3,
	descBigSuccess = 22,
	positionParam = 4,
	selectType = 24,
	afterSelect = 9,
	descSuccess = 17,
	id = 1,
	interactiveBigSuccess = 23,
	weight = 5,
	attribute = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_choice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_choice, "configList", _configList)
	rawset(lua_rouge2_choice, "configDict", _configDict)
end

setmetatable(lua_rouge2_choice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_choice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_choice, "configList", nil)
	rawset(lua_rouge2_choice, "configDict", nil)
end

return lua_rouge2_choice
