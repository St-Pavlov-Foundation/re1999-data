-- chunkname: @modules/configs/excel2json/lua_battle.lua

module("modules.configs.excel2json.lua_battle", package.seeall)

local lua_battle = {}
local fields = {
	restrictReason = 28,
	trialMainAct104EuqipId = 32,
	battleEffectiveness = 23,
	noClothSkill = 8,
	fightDec = 22,
	talentEffectiveness = 26,
	monsterMax = 10,
	useTemp = 18,
	clothSkill = 17,
	maxRound = 11,
	bossHpType = 38,
	noAutoFight = 35,
	sceneIds = 3,
	additionRule = 15,
	actShow = 39,
	actionRule = 34,
	heroEffectiveness = 24,
	winCondition = 12,
	myStance = 16,
	playerMax = 9,
	balance = 33,
	fightTitle = 21,
	aiLink = 37,
	bgmevent = 20,
	id = 1,
	dialogParam = 19,
	trialHeros = 29,
	equipEffectiveness = 25,
	monsterGroupIds = 2,
	previewSkinId = 5,
	restrictRoles = 27,
	roleNum = 6,
	trialLimit = 30,
	hiddenRule = 14,
	advancedCondition = 13,
	focusMonsterId = 4,
	aid = 7,
	onlyTrial = 36,
	trialEquips = 31
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	restrictReason = 1
}
local _configList, _configDict
local configPath = "configs.battle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_battle, "configList", _configList)
	rawset(lua_battle, "configDict", _configDict)
end

setmetatable(lua_battle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_battle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_battle, "configList", nil)
	rawset(lua_battle, "configDict", nil)
end

return lua_battle
