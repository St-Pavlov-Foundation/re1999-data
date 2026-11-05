-- chunkname: @modules/configs/excel2json/lua_survival_shelter_monster_act.lua

module("modules.configs.excel2json.lua_survival_shelter_monster_act", package.seeall)

local lua_survival_shelter_monster_act = {}
local fields = {
	round9 = 12,
	round4 = 7,
	round7 = 10,
	round3 = 6,
	monsterSpeed = 3,
	round6 = 9,
	round10 = 13,
	round5 = 8,
	fightId = 1,
	round8 = 11,
	monsterID = 2,
	round2 = 5,
	round1 = 4
}
local primaryKey = {
	"fightId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_shelter_monster_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shelter_monster_act, "configList", _configList)
	rawset(lua_survival_shelter_monster_act, "configDict", _configDict)
end

setmetatable(lua_survival_shelter_monster_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shelter_monster_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shelter_monster_act, "configList", nil)
	rawset(lua_survival_shelter_monster_act, "configDict", nil)
end

return lua_survival_shelter_monster_act
