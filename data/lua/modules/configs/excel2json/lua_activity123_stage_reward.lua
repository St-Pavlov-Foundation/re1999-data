-- chunkname: @modules/configs/excel2json/lua_activity123_stage_reward.lua

module("modules.configs.excel2json.lua_activity123_stage_reward", package.seeall)

local lua_activity123_stage_reward = {}
local fields = {
	stageId = 3,
	star = 4,
	keyReward = 7,
	bonusId = 2,
	bonusIcon = 5,
	activityId = 1,
	bonus = 6
}
local primaryKey = {
	"activityId",
	"bonusId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity123_stage_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_stage_reward, "configList", _configList)
	rawset(lua_activity123_stage_reward, "configDict", _configDict)
end

setmetatable(lua_activity123_stage_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_stage_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_stage_reward, "configList", nil)
	rawset(lua_activity123_stage_reward, "configDict", nil)
end

return lua_activity123_stage_reward
