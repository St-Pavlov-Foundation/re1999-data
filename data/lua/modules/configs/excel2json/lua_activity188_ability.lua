-- chunkname: @modules/configs/excel2json/lua_activity188_ability.lua

module("modules.configs.excel2json.lua_activity188_ability", package.seeall)

local lua_activity188_ability = {}
local fields = {
	effectTime = 3,
	skillId = 4,
	abilityId = 2,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"abilityId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity188_ability_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_ability, "configList", _configList)
	rawset(lua_activity188_ability, "configDict", _configDict)
end

setmetatable(lua_activity188_ability, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_ability.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_ability, "configList", nil)
	rawset(lua_activity188_ability, "configDict", nil)
end

return lua_activity188_ability
