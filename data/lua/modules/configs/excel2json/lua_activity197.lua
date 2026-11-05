-- chunkname: @modules/configs/excel2json/lua_activity197.lua

module("modules.configs.excel2json.lua_activity197", package.seeall)

local lua_activity197 = {}
local fields = {
	rummageConsume = 2,
	doubleTimes = 6,
	exploreNum = 5,
	activityConsume = 7,
	exploreConsume = 3,
	exploreItem = 4,
	activityId = 1,
	consumeBonus = 8
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity197_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity197, "configList", _configList)
	rawset(lua_activity197, "configDict", _configDict)
end

setmetatable(lua_activity197, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity197.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity197, "configList", nil)
	rawset(lua_activity197, "configDict", nil)
end

return lua_activity197
