-- chunkname: @modules/configs/excel2json/lua_room_order_refresh.lua

module("modules.configs.excel2json.lua_room_order_refresh", package.seeall)

local lua_room_order_refresh = {}
local fields = {
	wholesaleRevenueWeeklyLimit = 5,
	finishLimitDaily = 3,
	wholesaleGoodsWeight = 6,
	meanwhileWholesaleNum = 4,
	qualityWeight = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_order_refresh_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_order_refresh, "configList", _configList)
	rawset(lua_room_order_refresh, "configDict", _configDict)
end

setmetatable(lua_room_order_refresh, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_order_refresh.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_order_refresh, "configList", nil)
	rawset(lua_room_order_refresh, "configDict", nil)
end

return lua_room_order_refresh
