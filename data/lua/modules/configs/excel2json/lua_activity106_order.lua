-- chunkname: @modules/configs/excel2json/lua_activity106_order.lua

module("modules.configs.excel2json.lua_activity106_order", package.seeall)

local lua_activity106_order = {}
local fields = {
	gameSetting = 14,
	name = 4,
	titledesc = 5,
	openDay = 11,
	infoDesc = 17,
	desc = 6,
	listenerParam = 9,
	maxProgress = 10,
	activityId = 1,
	order = 15,
	jumpId = 16,
	location = 7,
	rare = 3,
	listenerType = 8,
	id = 2,
	bossPic = 13,
	bonus = 12
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1,
	location = 4,
	titledesc = 2,
	infoDesc = 5,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity106_order_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity106_order, "configList", _configList)
	rawset(lua_activity106_order, "configDict", _configDict)
end

setmetatable(lua_activity106_order, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity106_order.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity106_order, "configList", nil)
	rawset(lua_activity106_order, "configDict", nil)
end

return lua_activity106_order
