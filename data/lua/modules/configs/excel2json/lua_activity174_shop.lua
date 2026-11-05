-- chunkname: @modules/configs/excel2json/lua_activity174_shop.lua

module("modules.configs.excel2json.lua_activity174_shop", package.seeall)

local lua_activity174_shop = {}
local fields = {
	id = 1,
	name = 5,
	season = 3,
	activityId = 2,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity174_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_shop, "configList", _configList)
	rawset(lua_activity174_shop, "configDict", _configDict)
end

setmetatable(lua_activity174_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_shop, "configList", nil)
	rawset(lua_activity174_shop, "configDict", nil)
end

return lua_activity174_shop
