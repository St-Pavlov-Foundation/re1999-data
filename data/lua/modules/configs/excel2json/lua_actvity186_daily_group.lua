-- chunkname: @modules/configs/excel2json/lua_actvity186_daily_group.lua

module("modules.configs.excel2json.lua_actvity186_daily_group", package.seeall)

local lua_actvity186_daily_group = {}
local fields = {
	acceptInterval = 5,
	bonus = 6,
	rewardId = 2,
	groupId = 1,
	acceptTime = 3,
	isLoopBonus = 4
}
local primaryKey = {
	"groupId",
	"rewardId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.actvity186_daily_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity186_daily_group, "configList", _configList)
	rawset(lua_actvity186_daily_group, "configDict", _configDict)
end

setmetatable(lua_actvity186_daily_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity186_daily_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity186_daily_group, "configList", nil)
	rawset(lua_actvity186_daily_group, "configDict", nil)
end

return lua_actvity186_daily_group
