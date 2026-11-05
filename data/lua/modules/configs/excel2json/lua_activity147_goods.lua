-- chunkname: @modules/configs/excel2json/lua_activity147_goods.lua

module("modules.configs.excel2json.lua_activity147_goods", package.seeall)

local lua_activity147_goods = {}
local fields = {
	cost = 4,
	maxBuyCount = 5,
	product = 3,
	type = 6,
	id = 2,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity147_goods_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity147_goods, "configList", _configList)
	rawset(lua_activity147_goods, "configDict", _configDict)
end

setmetatable(lua_activity147_goods, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity147_goods.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity147_goods, "configList", nil)
	rawset(lua_activity147_goods, "configDict", nil)
end

return lua_activity147_goods
