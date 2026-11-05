-- chunkname: @modules/configs/excel2json/lua_activity165_reward.lua

module("modules.configs.excel2json.lua_activity165_reward", package.seeall)

local lua_activity165_reward = {}
local fields = {
	bonus = 3,
	showPos = 4,
	endingCount = 2,
	storyId = 1
}
local primaryKey = {
	"storyId",
	"endingCount"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity165_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity165_reward, "configList", _configList)
	rawset(lua_activity165_reward, "configDict", _configDict)
end

setmetatable(lua_activity165_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity165_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity165_reward, "configList", nil)
	rawset(lua_activity165_reward, "configDict", nil)
end

return lua_activity165_reward
