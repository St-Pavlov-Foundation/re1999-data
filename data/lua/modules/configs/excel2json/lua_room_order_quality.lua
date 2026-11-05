-- chunkname: @modules/configs/excel2json/lua_room_order_quality.lua

module("modules.configs.excel2json.lua_room_order_quality", package.seeall)

local lua_room_order_quality = {}
local fields = {
	goodsWeight = 3,
	quality = 1,
	price = 2,
	typeCount = 4
}
local primaryKey = {
	"quality"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_order_quality_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_order_quality, "configList", _configList)
	rawset(lua_room_order_quality, "configDict", _configDict)
end

setmetatable(lua_room_order_quality, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_order_quality.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_order_quality, "configList", nil)
	rawset(lua_room_order_quality, "configDict", nil)
end

return lua_room_order_quality
