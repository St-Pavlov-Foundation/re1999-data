-- chunkname: @modules/configs/excel2json/lua_activity191_role.lua

module("modules.configs.excel2json.lua_activity191_role", package.seeall)

local lua_activity191_role = {}
local fields = {
	roleId = 10,
	name = 11,
	type = 3,
	skinId = 5,
	uniqueSkill = 18,
	gender = 12,
	career = 13,
	activeSkill2 = 17,
	star = 7,
	activeSkill1 = 16,
	dmgType = 14,
	quality = 6,
	tag = 9,
	uniqueSkill_point = 19,
	activityId = 2,
	powerMax = 20,
	facetsId = 21,
	passiveSkill = 15,
	exLevel = 8,
	template = 4,
	id = 1,
	weight = 22
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_role_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_role, "configList", _configList)
	rawset(lua_activity191_role, "configDict", _configDict)
end

setmetatable(lua_activity191_role, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_role.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_role, "configList", nil)
	rawset(lua_activity191_role, "configDict", nil)
end

return lua_activity191_role
