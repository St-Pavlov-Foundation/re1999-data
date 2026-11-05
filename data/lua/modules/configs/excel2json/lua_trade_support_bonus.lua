-- chunkname: @modules/configs/excel2json/lua_trade_support_bonus.lua

module("modules.configs.excel2json.lua_trade_support_bonus", package.seeall)

local lua_trade_support_bonus = {}
local fields = {
	id = 1,
	needTask = 3,
	bonus = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.trade_support_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trade_support_bonus, "configList", _configList)
	rawset(lua_trade_support_bonus, "configDict", _configDict)
end

setmetatable(lua_trade_support_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trade_support_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trade_support_bonus, "configList", nil)
	rawset(lua_trade_support_bonus, "configDict", nil)
end

return lua_trade_support_bonus
