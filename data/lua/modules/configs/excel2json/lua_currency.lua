-- chunkname: @modules/configs/excel2json/lua_currency.lua

module("modules.configs.excel2json.lua_currency", package.seeall)

local lua_currency = {}
local fields = {
	subType = 3,
	name = 2,
	useDesc = 8,
	maxLimit = 14,
	dayRecoverNum = 13,
	headIconSign = 16,
	rare = 4,
	desc = 9,
	recoverTime = 10,
	smallIcon = 7,
	recoverLimit = 12,
	sources = 15,
	id = 1,
	icon = 6,
	recoverNum = 11,
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
local configPath = "configs.currency_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_currency, "configList", _configList)
	rawset(lua_currency, "configDict", _configDict)
end

setmetatable(lua_currency, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_currency.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_currency, "configList", nil)
	rawset(lua_currency, "configDict", nil)
end

return lua_currency
