-- chunkname: @modules/configs/excel2json/lua_power_item.lua

module("modules.configs.excel2json.lua_power_item", package.seeall)

local lua_power_item = {}
local fields = {
	expireTime = 7,
	name = 2,
	useDesc = 8,
	expireType = 6,
	effect = 10,
	sources = 11,
	rare = 4,
	desc = 9,
	itemSortIdx = 12,
	id = 1,
	icon = 3,
	highQuality = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.power_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_power_item, "configList", _configList)
	rawset(lua_power_item, "configDict", _configDict)
end

setmetatable(lua_power_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_power_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_power_item, "configList", nil)
	rawset(lua_power_item, "configDict", nil)
end

return lua_power_item
