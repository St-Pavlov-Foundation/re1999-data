-- chunkname: @modules/configs/excel2json/lua_college_reward.lua

module("modules.configs.excel2json.lua_college_reward", package.seeall)

local lua_college_reward = {}
local fields = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.college_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_reward, "configList", _configList)
	rawset(lua_college_reward, "configDict", _configDict)
end

setmetatable(lua_college_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_reward, "configList", nil)
	rawset(lua_college_reward, "configDict", nil)
end

return lua_college_reward
