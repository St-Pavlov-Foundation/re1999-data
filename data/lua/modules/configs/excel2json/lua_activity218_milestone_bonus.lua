-- chunkname: @modules/configs/excel2json/lua_activity218_milestone_bonus.lua

module("modules.configs.excel2json.lua_activity218_milestone_bonus", package.seeall)

local lua_activity218_milestone_bonus = {}
local fields = {
	isSpBonus = 5,
	coinNum = 3,
	rewardId = 2,
	source = 6,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"rewardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity218_milestone_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity218_milestone_bonus, "configList", _configList)
	rawset(lua_activity218_milestone_bonus, "configDict", _configDict)
end

setmetatable(lua_activity218_milestone_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity218_milestone_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity218_milestone_bonus, "configList", nil)
	rawset(lua_activity218_milestone_bonus, "configDict", nil)
end

return lua_activity218_milestone_bonus
