-- chunkname: @modules/configs/excel2json/lua_survival_shelter_invasion_fight.lua

module("modules.configs.excel2json.lua_survival_shelter_invasion_fight", package.seeall)

local lua_survival_shelter_invasion_fight = {}
local fields = {
	destructionLevel = 6,
	fightId = 2,
	schemeGroup = 5,
	id = 1,
	initSchemeGroup = 3,
	extraSchemeGroup = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_shelter_invasion_fight_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shelter_invasion_fight, "configList", _configList)
	rawset(lua_survival_shelter_invasion_fight, "configDict", _configDict)
end

setmetatable(lua_survival_shelter_invasion_fight, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shelter_invasion_fight.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shelter_invasion_fight, "configList", nil)
	rawset(lua_survival_shelter_invasion_fight, "configDict", nil)
end

return lua_survival_shelter_invasion_fight
