-- chunkname: @modules/configs/excel2json/lua_rogue_goods.lua

module("modules.configs.excel2json.lua_rogue_goods", package.seeall)

local lua_rogue_goods = {}
local fields = {
	weights = 5,
	goodsGroup = 2,
	creator = 6,
	currency = 3,
	id = 1,
	event = 7,
	price = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_goods_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_goods, "configList", _configList)
	rawset(lua_rogue_goods, "configDict", _configDict)
end

setmetatable(lua_rogue_goods, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_goods.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_goods, "configList", nil)
	rawset(lua_rogue_goods, "configDict", nil)
end

return lua_rogue_goods
