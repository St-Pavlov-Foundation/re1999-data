-- chunkname: @modules/configs/excel2json/lua_version_activity_puzzle_question.lua

module("modules.configs.excel2json.lua_version_activity_puzzle_question", package.seeall)

local lua_version_activity_puzzle_question = {}
local fields = {
	id = 1,
	text = 3,
	answer = 4,
	tittle = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 2,
	answer = 3,
	tittle = 1
}
local _configList, _configDict
local configPath = "configs.version_activity_puzzle_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_version_activity_puzzle_question, "configList", _configList)
	rawset(lua_version_activity_puzzle_question, "configDict", _configDict)
end

setmetatable(lua_version_activity_puzzle_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_version_activity_puzzle_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_version_activity_puzzle_question, "configList", nil)
	rawset(lua_version_activity_puzzle_question, "configDict", nil)
end

return lua_version_activity_puzzle_question
