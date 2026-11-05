-- chunkname: @modules/configs/excel2json/lua_weekwalk_rule.lua

module("modules.configs.excel2json.lua_weekwalk_rule", package.seeall)

local lua_weekwalk_rule = {}
local fields = {
	id = 1,
	icon = 2,
	isCn = 4,
	additionRule = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_rule, "configList", _configList)
	rawset(lua_weekwalk_rule, "configDict", _configDict)
end

setmetatable(lua_weekwalk_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_rule, "configList", nil)
	rawset(lua_weekwalk_rule, "configDict", nil)
end

return lua_weekwalk_rule
