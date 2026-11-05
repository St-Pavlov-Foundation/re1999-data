-- chunkname: @modules/configs/excel2json/lua_weekwalk_question.lua

module("modules.configs.excel2json.lua_weekwalk_question", package.seeall)

local lua_weekwalk_question = {}
local fields = {
	text = 2,
	select3 = 5,
	select2 = 4,
	id = 1,
	select1 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1,
	select1 = 2,
	select3 = 4,
	select2 = 3
}
local _configList, _configDict
local configPath = "configs.weekwalk_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_question, "configList", _configList)
	rawset(lua_weekwalk_question, "configDict", _configDict)
end

setmetatable(lua_weekwalk_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_question, "configList", nil)
	rawset(lua_weekwalk_question, "configDict", nil)
end

return lua_weekwalk_question
