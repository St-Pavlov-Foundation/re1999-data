-- chunkname: @modules/configs/excel2json/lua_reward_source.lua

module("modules.configs.excel2json.lua_reward_source", package.seeall)

local lua_reward_source = {}
local fields = {
	sourceid = 1
}
local primaryKey = {
	"sourceid"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.reward_source_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_reward_source, "configList", _configList)
	rawset(lua_reward_source, "configDict", _configDict)
end

setmetatable(lua_reward_source, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_reward_source.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_reward_source, "configList", nil)
	rawset(lua_reward_source, "configDict", nil)
end

return lua_reward_source
