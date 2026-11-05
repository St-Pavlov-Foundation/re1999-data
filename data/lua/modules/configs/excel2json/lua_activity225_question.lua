-- chunkname: @modules/configs/excel2json/lua_activity225_question.lua

module("modules.configs.excel2json.lua_activity225_question", package.seeall)

local lua_activity225_question = {}
local fields = {
	npcId = 3,
	question = 4,
	id = 2,
	answerIds = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	question = 1
}
local _configList, _configDict
local configPath = "configs.activity225_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_question, "configList", _configList)
	rawset(lua_activity225_question, "configDict", _configDict)
end

setmetatable(lua_activity225_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_question, "configList", nil)
	rawset(lua_activity225_question, "configDict", nil)
end

return lua_activity225_question
