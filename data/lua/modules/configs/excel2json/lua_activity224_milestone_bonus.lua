-- chunkname: @modules/configs/excel2json/lua_activity224_milestone_bonus.lua

module("modules.configs.excel2json.lua_activity224_milestone_bonus", package.seeall)

local lua_activity224_milestone_bonus = {}
local fields = {
	bonus = 6,
	isSpBonus = 7,
	coinNum = 3,
	loopBonusIntervalNum = 5,
	id = 2,
	titleId = 8,
	activityId = 1,
	isLoopBonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity224_milestone_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity224_milestone_bonus, "configList", _configList)
	rawset(lua_activity224_milestone_bonus, "configDict", _configDict)
end

setmetatable(lua_activity224_milestone_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity224_milestone_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity224_milestone_bonus, "configList", nil)
	rawset(lua_activity224_milestone_bonus, "configDict", nil)
end

return lua_activity224_milestone_bonus
