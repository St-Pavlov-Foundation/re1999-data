-- chunkname: @modules/configs/excel2json/lua_store_charge_conditional.lua

module("modules.configs.excel2json.lua_store_charge_conditional", package.seeall)

local lua_store_charge_conditional = {}
local fields = {
	clientType = 14,
	order2 = 9,
	redDot = 12,
	signInIdParam = 11,
	bigImg3 = 7,
	conDesc = 10,
	idsStr = 13,
	listenerType = 2,
	listenerParam = 3,
	id = 8,
	goodsId = 1,
	maxProgress = 4,
	bigImg2 = 6,
	bonus = 5
}
local primaryKey = {
	"goodsId"
}
local mlStringKey = {
	conDesc = 1
}
local _configList, _configDict
local configPath = "configs.store_charge_conditional_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_charge_conditional, "configList", _configList)
	rawset(lua_store_charge_conditional, "configDict", _configDict)
end

setmetatable(lua_store_charge_conditional, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_charge_conditional.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_charge_conditional, "configList", nil)
	rawset(lua_store_charge_conditional, "configDict", nil)
end

return lua_store_charge_conditional
