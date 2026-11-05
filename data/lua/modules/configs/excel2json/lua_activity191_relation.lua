-- chunkname: @modules/configs/excel2json/lua_activity191_relation.lua

module("modules.configs.excel2json.lua_activity191_relation", package.seeall)

local lua_activity191_relation = {}
local fields = {
	id = 1,
	name = 4,
	activeNum = 7,
	levelDesc = 9,
	specDesc = 10,
	summon = 13,
	tagBg = 6,
	desc = 8,
	effects = 11,
	tag = 3,
	icon = 12,
	activityId = 2,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	specDesc = 4,
	name = 1,
	levelDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity191_relation_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_relation, "configList", _configList)
	rawset(lua_activity191_relation, "configDict", _configDict)
end

setmetatable(lua_activity191_relation, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_relation.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_relation, "configList", nil)
	rawset(lua_activity191_relation, "configDict", nil)
end

return lua_activity191_relation
