-- chunkname: @modules/configs/excel2json/lua_survival_shelter_intrude_fight.lua

module("modules.configs.excel2json.lua_survival_shelter_intrude_fight", package.seeall)

local lua_survival_shelter_intrude_fight = {}
local fields = {
	target = 2,
	destructionLevel = 16,
	name = 10,
	cleanLevel = 14,
	gridType = 8,
	cleanpoint = 15,
	desc = 11,
	saveMonster = 13,
	model = 6,
	battleId = 3,
	smallheadicon = 9,
	score = 4,
	image = 5,
	toward = 12,
	drop = 17,
	id = 1,
	scale = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	target = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.survival_shelter_intrude_fight_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shelter_intrude_fight, "configList", _configList)
	rawset(lua_survival_shelter_intrude_fight, "configDict", _configDict)
end

setmetatable(lua_survival_shelter_intrude_fight, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shelter_intrude_fight.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shelter_intrude_fight, "configList", nil)
	rawset(lua_survival_shelter_intrude_fight, "configDict", nil)
end

return lua_survival_shelter_intrude_fight
