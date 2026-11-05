-- chunkname: @modules/configs/excel2json/lua_survival_behavior.lua

module("modules.configs.excel2json.lua_survival_behavior", package.seeall)

local lua_survival_behavior = {}
local fields = {
	chooseEvent = 6,
	priority = 3,
	chooseDesc = 5,
	condition = 2,
	id = 1,
	dialogueId = 4,
	isMark = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	chooseDesc = 1
}
local _configList, _configDict
local configPath = "configs.survival_behavior_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_behavior, "configList", _configList)
	rawset(lua_survival_behavior, "configDict", _configDict)
end

setmetatable(lua_survival_behavior, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_behavior.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_behavior, "configList", nil)
	rawset(lua_survival_behavior, "configDict", nil)
end

return lua_survival_behavior
