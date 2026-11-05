-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_collection_rule.lua

module("modules.configs.excel2json.lua_arcade_survivor_collection_rule", package.seeall)

local lua_arcade_survivor_collection_rule = {}
local fields = {
	id = 1,
	typeParam = 3,
	reapply = 4,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_collection_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_collection_rule, "configList", _configList)
	rawset(lua_arcade_survivor_collection_rule, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_collection_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_collection_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_collection_rule, "configList", nil)
	rawset(lua_arcade_survivor_collection_rule, "configDict", nil)
end

return lua_arcade_survivor_collection_rule
