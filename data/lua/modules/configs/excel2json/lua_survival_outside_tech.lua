-- chunkname: @modules/configs/excel2json/lua_survival_outside_tech.lua

module("modules.configs.excel2json.lua_survival_outside_tech", package.seeall)

local lua_survival_outside_tech = {}
local fields = {
	cost = 10,
	name = 2,
	belongRole = 3,
	sign = 11,
	desc = 6,
	preNodes = 7,
	point = 4,
	id = 1,
	icon = 5,
	addTalentIds = 8,
	extendScoreFix = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_outside_tech_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_outside_tech, "configList", _configList)
	rawset(lua_survival_outside_tech, "configDict", _configDict)
end

setmetatable(lua_survival_outside_tech, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_outside_tech.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_outside_tech, "configList", nil)
	rawset(lua_survival_outside_tech, "configDict", nil)
end

return lua_survival_outside_tech
