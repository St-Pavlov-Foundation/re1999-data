-- chunkname: @modules/configs/excel2json/lua_store_push_goods.lua

module("modules.configs.excel2json.lua_store_push_goods", package.seeall)

local lua_store_push_goods = {}
local fields = {
	gapHours = 5,
	desc = 7,
	levelLimits = 9,
	typeId = 4,
	className = 6,
	listenerType = 2,
	listenerParam = 3,
	goodpushsId = 1,
	containedgoodsId = 8
}
local primaryKey = {
	"goodpushsId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.store_push_goods_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_push_goods, "configList", _configList)
	rawset(lua_store_push_goods, "configDict", _configDict)
end

setmetatable(lua_store_push_goods, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_push_goods.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_push_goods, "configList", nil)
	rawset(lua_store_push_goods, "configDict", nil)
end

return lua_store_push_goods
