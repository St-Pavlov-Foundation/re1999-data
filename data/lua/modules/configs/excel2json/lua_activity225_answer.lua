-- chunkname: @modules/configs/excel2json/lua_activity225_answer.lua

module("modules.configs.excel2json.lua_activity225_answer", package.seeall)

local lua_activity225_answer = {}
local fields = {
	answerId = 1,
	answerTxt = 2,
	answerComment = 3
}
local primaryKey = {
	"answerId"
}
local mlStringKey = {
	answerComment = 2,
	answerTxt = 1
}
local _configList, _configDict
local configPath = "configs.activity225_answer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_answer, "configList", _configList)
	rawset(lua_activity225_answer, "configDict", _configDict)
end

setmetatable(lua_activity225_answer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_answer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_answer, "configList", nil)
	rawset(lua_activity225_answer, "configDict", nil)
end

return lua_activity225_answer
