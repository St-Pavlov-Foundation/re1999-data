-- chunkname: @modules/configs/excel2json/lua_actvity204_milestone_bonus.lua

module("modules.configs.excel2json.lua_actvity204_milestone_bonus", package.seeall)

local lua_actvity204_milestone_bonus = {}
local fields = {
	loopBonusIntervalNum = 5,
	isSpBonus = 7,
	coinNum = 3,
	rewardId = 2,
	bonus = 6,
	activityId = 1,
	isLoopBonus = 4
}
local primaryKey = {
	"activityId",
	"rewardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.actvity204_milestone_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity204_milestone_bonus, "configList", _configList)
	rawset(lua_actvity204_milestone_bonus, "configDict", _configDict)
end

setmetatable(lua_actvity204_milestone_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity204_milestone_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity204_milestone_bonus, "configList", nil)
	rawset(lua_actvity204_milestone_bonus, "configDict", nil)
end

return lua_actvity204_milestone_bonus
