-- chunkname: @modules/configs/excel2json/lua_reward_group.lua

module("modules.configs.excel2json.lua_reward_group", package.seeall)

local lua_reward_group = {}
local fields = {
	group = 2,
	materialId = 4,
	count = 5,
	shownum = 7,
	id = 1,
	label = 6,
	materialType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.reward_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_reward_group, "configList", _configList)
	rawset(lua_reward_group, "configDict", _configDict)
end

setmetatable(lua_reward_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_reward_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_reward_group, "configList", nil)
	rawset(lua_reward_group, "configDict", nil)
end

return lua_reward_group
