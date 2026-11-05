-- chunkname: @modules/configs/excel2json/lua_auto_chess_mall_coin.lua

module("modules.configs.excel2json.lua_auto_chess_mall_coin", package.seeall)

local lua_auto_chess_mall_coin = {}
local fields = {
	activityId = 1,
	coinNum = 3,
	round = 2,
	refreshCost = 4
}
local primaryKey = {
	"activityId",
	"round"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_mall_coin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_mall_coin, "configList", _configList)
	rawset(lua_auto_chess_mall_coin, "configDict", _configDict)
end

setmetatable(lua_auto_chess_mall_coin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_mall_coin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_mall_coin, "configList", nil)
	rawset(lua_auto_chess_mall_coin, "configDict", nil)
end

return lua_auto_chess_mall_coin
