-- chunkname: @modules/configs/excel2json/lua_store_charge_optional.lua

module("modules.configs.excel2json.lua_store_charge_optional", package.seeall)

local lua_store_charge_optional = {}
local fields = {
	id = 2,
	name = 6,
	items = 5,
	type = 4,
	goodsId = 1,
	rare = 3,
	desc = 7
}
local primaryKey = {
	"goodsId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.store_charge_optional_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_charge_optional, "configList", _configList)
	rawset(lua_store_charge_optional, "configDict", _configDict)
end

setmetatable(lua_store_charge_optional, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_charge_optional.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_charge_optional, "configList", nil)
	rawset(lua_store_charge_optional, "configDict", nil)
end

return lua_store_charge_optional
