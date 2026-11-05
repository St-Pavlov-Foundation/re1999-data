-- chunkname: @modules/configs/excel2json/lua_survival_item.lua

module("modules.configs.excel2json.lua_survival_item", package.seeall)

local lua_survival_item = {}
local fields = {
	desc2 = 6,
	name = 2,
	sellPrice = 8,
	type = 10,
	exp = 24,
	worth = 16,
	overlayLimit = 17,
	isDestroy = 18,
	versions = 3,
	subType = 11,
	enhanceCond = 21,
	copyItem = 23,
	sublimateDrop = 25,
	icon = 9,
	desc1 = 5,
	cost = 15,
	effect = 20,
	deposit = 12,
	maxLimit = 22,
	exchange = 19,
	rare = 13,
	seasons = 4,
	id = 1,
	disposable = 7,
	mass = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.survival_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_item, "configList", _configList)
	rawset(lua_survival_item, "configDict", _configDict)
end

setmetatable(lua_survival_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_item, "configList", nil)
	rawset(lua_survival_item, "configDict", nil)
end

return lua_survival_item
