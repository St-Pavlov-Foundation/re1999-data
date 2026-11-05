-- chunkname: @modules/configs/excel2json/lua_rogue_shop.lua

module("modules.configs.excel2json.lua_rogue_shop", package.seeall)

local lua_rogue_shop = {}
local fields = {
	desc = 2,
	pos13 = 15,
	pos12 = 14,
	pos5 = 7,
	pos1 = 3,
	pos8 = 10,
	pos4 = 6,
	pos14 = 16,
	pos15 = 17,
	pos6 = 8,
	pos10 = 12,
	pos16 = 18,
	pos9 = 11,
	pos11 = 13,
	pos3 = 5,
	pos7 = 9,
	pos2 = 4,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rogue_shop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_shop, "configList", _configList)
	rawset(lua_rogue_shop, "configDict", _configDict)
end

setmetatable(lua_rogue_shop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_shop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_shop, "configList", nil)
	rawset(lua_rogue_shop, "configDict", nil)
end

return lua_rogue_shop
