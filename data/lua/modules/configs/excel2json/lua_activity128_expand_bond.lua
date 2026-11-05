-- chunkname: @modules/configs/excel2json/lua_activity128_expand_bond.lua

module("modules.configs.excel2json.lua_activity128_expand_bond", package.seeall)

local lua_activity128_expand_bond = {}
local fields = {
	tagType = 6,
	name = 7,
	activeNum = 9,
	backingIcon = 12,
	groupId = 5,
	tag2 = 4,
	numberIcon = 14,
	desc = 10,
	effects = 11,
	tag1 = 3,
	id = 1,
	icon = 13,
	activityId = 2,
	level = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity128_expand_bond_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_expand_bond, "configList", _configList)
	rawset(lua_activity128_expand_bond, "configDict", _configDict)
end

setmetatable(lua_activity128_expand_bond, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_expand_bond.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_expand_bond, "configList", nil)
	rawset(lua_activity128_expand_bond, "configDict", nil)
end

return lua_activity128_expand_bond
