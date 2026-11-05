-- chunkname: @modules/configs/excel2json/lua_activity191_shop.lua

module("modules.configs.excel2json.lua_activity191_shop", package.seeall)

local lua_activity191_shop = {}
local fields = {
	position = 6,
	name = 7,
	desc = 8,
	type = 3,
	id = 2,
	stage = 5,
	activityId = 1,
	level = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_shop, "configList", _configList)
	rawset(lua_activity191_shop, "configDict", _configDict)
end

setmetatable(lua_activity191_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_shop, "configList", nil)
	rawset(lua_activity191_shop, "configDict", nil)
end

return lua_activity191_shop
