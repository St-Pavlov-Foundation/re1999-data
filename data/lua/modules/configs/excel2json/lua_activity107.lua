-- chunkname: @modules/configs/excel2json/lua_activity107.lua

module("modules.configs.excel2json.lua_activity107", package.seeall)

local lua_activity107 = {}
local fields = {
	cost = 5,
	name = 8,
	tag = 6,
	offTag = 13,
	group = 12,
	order = 11,
	isOnline = 9,
	maxBuyCount = 4,
	bigImg = 7,
	originalCost = 14,
	product = 3,
	specProduct = 15,
	id = 2,
	isShowBtnDetail = 16,
	activityId = 1,
	preGoodsId = 10
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	offTag = 1
}
local _configList, _configDict
local configPath = "configs.activity107_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity107, "configList", _configList)
	rawset(lua_activity107, "configDict", _configDict)
end

setmetatable(lua_activity107, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity107.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity107, "configList", nil)
	rawset(lua_activity107, "configDict", nil)
end

return lua_activity107
