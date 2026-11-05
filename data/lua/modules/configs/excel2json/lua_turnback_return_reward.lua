-- chunkname: @modules/configs/excel2json/lua_turnback_return_reward.lua

module("modules.configs.excel2json.lua_turnback_return_reward", package.seeall)

local lua_turnback_return_reward = {}
local fields = {
	needVitality = 6,
	isOnline = 3,
	id = 1,
	turnbackId = 2,
	lossDaysRange = 4,
	bonus = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_return_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_return_reward, "configList", _configList)
	rawset(lua_turnback_return_reward, "configDict", _configDict)
end

setmetatable(lua_turnback_return_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_return_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_return_reward, "configList", nil)
	rawset(lua_turnback_return_reward, "configDict", nil)
end

return lua_turnback_return_reward
