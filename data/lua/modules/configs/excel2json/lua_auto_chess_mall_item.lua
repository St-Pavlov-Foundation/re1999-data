-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall_item.lua

module("modules.configs.excel2json.lua_auto_chess_mall_item", package.seeall)

local lua_auto_chess_mall_item = {}
local fields = {
	context = 4,
	id = 1,
	goodsId = 2,
	cost = 5,
	group = 3,
	cardpackIds = 8,
	weight = 6,
	order = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_mall_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_mall_item, "configList", _configList)
	rawset(lua_auto_chess_mall_item, "configDict", _configDict)
end

setmetatable(lua_auto_chess_mall_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_mall_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_mall_item, "configList", nil)
	rawset(lua_auto_chess_mall_item, "configDict", nil)
end

return lua_auto_chess_mall_item
