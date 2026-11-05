-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_summoner.lua

module("modules.configs.excel2json.lua_fight_rouge2_summoner", package.seeall)

local lua_fight_rouge2_summoner = {}
local fields = {
	teamLevel = 15,
	name = 2,
	icon = 11,
	skinId = 16,
	stage = 7,
	gender = 18,
	career = 17,
	desc = 13,
	position = 8,
	descSimply = 14,
	dmgType = 19,
	type = 3,
	unlock = 9,
	keys = 5,
	attributeTag = 22,
	ordinal = 4,
	resMaxVal = 27,
	coldTime = 23,
	unlockCost = 6,
	effectId = 10,
	passiveSkills = 25,
	resInitVal = 26,
	monsterIcon = 21,
	heartVariantId = 20,
	activeSkills = 24,
	petIcon = 12,
	talentId = 1
}
local primaryKey = {
	"talentId"
}
local mlStringKey = {
	descSimply = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.fight_rouge2_summoner_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_rouge2_summoner, "configList", _configList)
	rawset(lua_fight_rouge2_summoner, "configDict", _configDict)
end

setmetatable(lua_fight_rouge2_summoner, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_rouge2_summoner.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_rouge2_summoner, "configList", nil)
	rawset(lua_fight_rouge2_summoner, "configDict", nil)
end

return lua_fight_rouge2_summoner
