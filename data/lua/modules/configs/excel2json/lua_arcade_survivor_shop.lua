-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_shop.lua

module("modules.configs.excel2json.lua_arcade_survivor_shop", package.seeall)

local lua_arcade_survivor_shop = {}
local fields = {
	goodsType = 2,
	slotParams = 4,
	slot = 3,
	tagWeight = 6,
	id = 1,
	weight = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_shop, "configList", _configList)
	rawset(lua_arcade_survivor_shop, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_shop, "configList", nil)
	rawset(lua_arcade_survivor_shop, "configDict", nil)
end

return lua_arcade_survivor_shop
