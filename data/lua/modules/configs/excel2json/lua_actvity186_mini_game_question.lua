-- chunkname: @modules/configs/excel2json/lua_actvity186_mini_game_question.lua

module("modules.configs.excel2json.lua_actvity186_mini_game_question", package.seeall)

local lua_actvity186_mini_game_question = {}
local fields = {
	rewardId1 = 7,
	rewardId2 = 10,
	question = 4,
	answer3 = 11,
	rewardId3 = 13,
	feedback3 = 12,
	hanzhangline4 = 14,
	answer2 = 8,
	feedback1 = 6,
	answer1 = 5,
	feedback2 = 9,
	id = 2,
	activityId = 1,
	sort = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	answer2 = 4,
	feedback1 = 3,
	question = 1,
	feedback2 = 5,
	hanzhangline4 = 8,
	feedback3 = 7,
	answer3 = 6,
	answer1 = 2
}
local _configList, _configDict
local configPath = "configs.actvity186_mini_game_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity186_mini_game_question, "configList", _configList)
	rawset(lua_actvity186_mini_game_question, "configDict", _configDict)
end

setmetatable(lua_actvity186_mini_game_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity186_mini_game_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity186_mini_game_question, "configList", nil)
	rawset(lua_actvity186_mini_game_question, "configDict", nil)
end

return lua_actvity186_mini_game_question
