-- chunkname: @modules/configs/excel2json/lua_activity191_shop_group.lua

module("modules.configs.excel2json.lua_activity191_shop_group", package.seeall)

local lua_activity191_shop_group = {}
local fields = {
	type = 4,
	groupType = 5,
	coin = 2,
	id = 1,
	num = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_shop_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_shop_group, "configList", _configList)
	rawset(lua_activity191_shop_group, "configDict", _configDict)
end

setmetatable(lua_activity191_shop_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_shop_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_shop_group, "configList", nil)
	rawset(lua_activity191_shop_group, "configDict", nil)
end

return lua_activity191_shop_group
