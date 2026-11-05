-- chunkname: @modules/configs/excel2json/lua_same_currency_exchange.lua

module("modules.configs.excel2json.lua_same_currency_exchange", package.seeall)

local lua_same_currency_exchange = {}
local fields = {
	currencyId = 1,
	desc = 3,
	storeEntranceId = 6,
	boxPath = 5,
	image = 4,
	versionId = 2
}
local primaryKey = {
	"currencyId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.same_currency_exchange_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_same_currency_exchange, "configList", _configList)
	rawset(lua_same_currency_exchange, "configDict", _configDict)
end

setmetatable(lua_same_currency_exchange, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_same_currency_exchange.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_same_currency_exchange, "configList", nil)
	rawset(lua_same_currency_exchange, "configDict", nil)
end

return lua_same_currency_exchange
