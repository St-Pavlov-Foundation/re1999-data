-- chunkname: @modules/configs/excel2json/lua_rouge_reward_stage.lua

module("modules.configs.excel2json.lua_rouge_reward_stage", package.seeall)

local lua_rouge_reward_stage = {}
local fields = {
	jump = 8,
	name = 6,
	icon = 5,
	stage = 2,
	season = 1,
	openTime = 9,
	bigRewardId = 4,
	pointLimit = 10,
	preStage = 3,
	lockName = 7
}
local primaryKey = {
	"season",
	"stage"
}
local mlStringKey = {
	lockName = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_reward_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_reward_stage, "configList", _configList)
	rawset(lua_rouge_reward_stage, "configDict", _configDict)
end

setmetatable(lua_rouge_reward_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_reward_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_reward_stage, "configList", nil)
	rawset(lua_rouge_reward_stage, "configDict", nil)
end

return lua_rouge_reward_stage
