-- chunkname: @modules/configs/excel2json/lua_partygame_findheart_question.lua

module("modules.configs.excel2json.lua_partygame_findheart_question", package.seeall)

local lua_partygame_findheart_question = {}
local fields = {
	id = 1,
	question = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	question = 1
}
local _configList, _configDict
local configPath = "configs.partygame_findheart_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_findheart_question, "configList", _configList)
	rawset(lua_partygame_findheart_question, "configDict", _configDict)
end

setmetatable(lua_partygame_findheart_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_findheart_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_findheart_question, "configList", nil)
	rawset(lua_partygame_findheart_question, "configDict", nil)
end

return lua_partygame_findheart_question
