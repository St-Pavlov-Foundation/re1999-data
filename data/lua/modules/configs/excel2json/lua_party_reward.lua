-- chunkname: @modules/configs/excel2json/lua_party_reward.lua

module("modules.configs.excel2json.lua_party_reward", package.seeall)

local lua_party_reward = {}
local fields = {
	rank = 1,
	reward = 2
}
local primaryKey = {
	"rank"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.party_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_reward, "configList", _configList)
	rawset(lua_party_reward, "configDict", _configDict)
end

setmetatable(lua_party_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_reward, "configList", nil)
	rawset(lua_party_reward, "configDict", nil)
end

return lua_party_reward
