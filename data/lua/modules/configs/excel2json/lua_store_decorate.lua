-- chunkname: @modules/configs/excel2json/lua_store_decorate.lua

module("modules.configs.excel2json.lua_store_decorate", package.seeall)

local lua_store_decorate = {}
local fields = {
	typeName = 7,
	video = 15,
	bundleBuylmg = 14,
	decorateskinOffset = 21,
	storeld = 2,
	maxbuycountType = 10,
	smalllmg = 11,
	desc = 8,
	originalCost1 = 18,
	subType = 4,
	linkTag = 26,
	tag1 = 17,
	biglmg = 12,
	decorateskinl2dOffset = 22,
	productType = 3,
	offTag = 20,
	showskinId = 24,
	buylmg = 13,
	bundleType = 5,
	tag2 = 25,
	rare = 9,
	effectbiglmg = 23,
	originalCost2 = 19,
	onlineTag = 16,
	id = 1,
	fatherGoods = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag1 = 3,
	typeName = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.store_decorate_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_decorate, "configList", _configList)
	rawset(lua_store_decorate, "configDict", _configDict)
end

setmetatable(lua_store_decorate, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_decorate.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_decorate, "configList", nil)
	rawset(lua_store_decorate, "configDict", nil)
end

return lua_store_decorate
