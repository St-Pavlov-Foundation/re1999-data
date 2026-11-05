-- chunkname: @modules/configs/excel2json/lua_fishing_exchange.lua

module("modules.configs.excel2json.lua_fishing_exchange", package.seeall)

local lua_fishing_exchange = {}
local fields = {
	num = 3,
	needCurrencyId = 2,
	times = 1
}
local primaryKey = {
	"times"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fishing_exchange_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fishing_exchange, "configList", _configList)
	rawset(lua_fishing_exchange, "configDict", _configDict)
end

setmetatable(lua_fishing_exchange, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fishing_exchange.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fishing_exchange, "configList", nil)
	rawset(lua_fishing_exchange, "configDict", nil)
end

return lua_fishing_exchange
