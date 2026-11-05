-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_currency.lua

module("modules.configs.excel2json.lua_arcade_survivor_currency", package.seeall)

local lua_arcade_survivor_currency = {}
local fields = {
	name = 5,
	min = 3,
	desc = 6,
	icon = 7,
	id = 1,
	initVal = 2,
	smallIcon = 8,
	max = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_currency_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_currency, "configList", _configList)
	rawset(lua_arcade_survivor_currency, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_currency, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_currency.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_currency, "configList", nil)
	rawset(lua_arcade_survivor_currency, "configDict", nil)
end

return lua_arcade_survivor_currency
