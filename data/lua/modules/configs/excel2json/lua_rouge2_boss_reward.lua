-- chunkname: @modules/configs/excel2json/lua_rouge2_boss_reward.lua

module("modules.configs.excel2json.lua_rouge2_boss_reward", package.seeall)

local lua_rouge2_boss_reward = {}
local fields = {
	reward = 4,
	score = 3,
	relics = 5,
	id = 1,
	stage = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_boss_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_boss_reward, "configList", _configList)
	rawset(lua_rouge2_boss_reward, "configDict", _configDict)
end

setmetatable(lua_rouge2_boss_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_boss_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_boss_reward, "configList", nil)
	rawset(lua_rouge2_boss_reward, "configDict", nil)
end

return lua_rouge2_boss_reward
