-- chunkname: @modules/configs/excel2json/lua_turnback.lua

module("modules.configs.excel2json.lua_turnback", package.seeall)

local lua_turnback = {}
local fields = {
	endStory = 8,
	name = 3,
	offlineDays = 4,
	monthCardAddedId = 19,
	additionRate = 14,
	additionType = 13,
	resourceReturnVitality = 28,
	durationDays = 6,
	endTime = 20,
	additionChapterIds = 15,
	buyDoubleBonusPrice = 23,
	bindActivityId = 2,
	taskBonusMailId = 9,
	startStory = 7,
	canBuyDoubleBonus = 22,
	buyBonus = 24,
	jumpId = 16,
	priority = 17,
	onlineDurationDays = 26,
	bonusList = 25,
	resourceReturnCondition = 27,
	additionDurationDays = 12,
	condition = 5,
	bonusPointMaterial = 18,
	onceBonus = 11,
	openDailyBonus = 21,
	id = 1,
	subModuleIds = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.turnback_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback, "configList", _configList)
	rawset(lua_turnback, "configDict", _configDict)
end

setmetatable(lua_turnback, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback, "configList", nil)
	rawset(lua_turnback, "configDict", nil)
end

return lua_turnback
