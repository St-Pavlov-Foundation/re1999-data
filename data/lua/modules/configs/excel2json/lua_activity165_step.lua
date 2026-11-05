-- chunkname: @modules/configs/excel2json/lua_activity165_step.lua

module("modules.configs.excel2json.lua_activity165_step", package.seeall)

local lua_activity165_step = {}
local fields = {
	text = 6,
	stepId = 1,
	answersKeywordIds = 4,
	nextStepConditionIds = 5,
	optionalKeywordIds = 3,
	pic = 7,
	belongStoryId = 2
}
local primaryKey = {
	"stepId"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.activity165_step_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity165_step, "configList", _configList)
	rawset(lua_activity165_step, "configDict", _configDict)
end

setmetatable(lua_activity165_step, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity165_step.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity165_step, "configList", nil)
	rawset(lua_activity165_step, "configDict", nil)
end

return lua_activity165_step
