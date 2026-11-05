-- chunkname: @modules/configs/excel2json/lua_activity117_order.lua

module("modules.configs.excel2json.lua_activity117_order", package.seeall)

local lua_activity117_order = {}
local fields = {
	openDay = 4,
	name = 3,
	maxAcceptScore = 7,
	minDealScore = 6,
	jumpId = 12,
	maxDealScore = 8,
	listenerType = 9,
	listenerParam = 10,
	id = 2,
	maxProgress = 11,
	activityId = 1,
	order = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity117_order_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity117_order, "configList", _configList)
	rawset(lua_activity117_order, "configDict", _configDict)
end

setmetatable(lua_activity117_order, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity117_order.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity117_order, "configList", nil)
	rawset(lua_activity117_order, "configDict", nil)
end

return lua_activity117_order
