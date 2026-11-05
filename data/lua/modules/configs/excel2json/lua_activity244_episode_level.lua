-- chunkname: @modules/configs/excel2json/lua_activity244_episode_level.lua

module("modules.configs.excel2json.lua_activity244_episode_level", package.seeall)

local lua_activity244_episode_level = {}
local fields = {
	feverTime = 11,
	levelGoal1 = 7,
	feverCost = 10,
	matchTime = 12,
	trialHeros = 16,
	levelGoal3 = 9,
	matchLevelId = 1,
	levelGoal2 = 8,
	gemTemplateId = 14,
	maxRound = 6,
	sceneUrl = 4,
	useTemp = 15,
	gemTypeNum = 13,
	monsterId = 3,
	boardLayoutId = 2,
	roleNum = 5
}
local primaryKey = {
	"matchLevelId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_episode_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_episode_level, "configList", _configList)
	rawset(lua_activity244_episode_level, "configDict", _configDict)
end

setmetatable(lua_activity244_episode_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_episode_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_episode_level, "configList", nil)
	rawset(lua_activity244_episode_level, "configDict", nil)
end

return lua_activity244_episode_level
