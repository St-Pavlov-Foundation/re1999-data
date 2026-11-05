-- chunkname: @modules/configs/excel2json/lua_rouge2_career.lua

module("modules.configs.excel2json.lua_rouge2_career", package.seeall)

local lua_rouge2_career = {}
local fields = {
	careerDesc = 5,
	passiveSkills = 15,
	initialEffects = 13,
	sortAttribute = 10,
	name = 2,
	recommendTeam = 18,
	mpMax = 20,
	unlock = 17,
	initialAttribute = 8,
	nameColor = 4,
	bagEntranceIcon = 7,
	attrMapBg = 22,
	isDifficult = 19,
	icon = 6,
	audioId = 24,
	unlockTime = 23,
	heroArmIcon = 25,
	passiveSkillBrief = 14,
	mpInitial = 21,
	initialColletions = 12,
	initialRevivalCoin = 11,
	activeSkills = 16,
	recommendAttribute = 9,
	id = 1,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	careerDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_career_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_career, "configList", _configList)
	rawset(lua_rouge2_career, "configDict", _configDict)
end

setmetatable(lua_rouge2_career, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_career.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_career, "configList", nil)
	rawset(lua_rouge2_career, "configDict", nil)
end

return lua_rouge2_career
