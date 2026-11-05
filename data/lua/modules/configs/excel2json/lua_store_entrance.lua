-- chunkname: @modules/configs/excel2json/lua_store_entrance.lua

module("modules.configs.excel2json.lua_store_entrance", package.seeall)

local lua_store_entrance = {}
local fields = {
	name = 4,
	prefab = 6,
	nameEn = 5,
	toprecommend = 16,
	activityId = 11,
	openTime = 12,
	belongFirstTab = 2,
	belongSecondTab = 3,
	storeId = 14,
	openHideId = 15,
	openId = 10,
	endTime = 13,
	id = 1,
	icon = 7,
	showCost = 9,
	order = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.store_entrance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_entrance, "configList", _configList)
	rawset(lua_store_entrance, "configDict", _configDict)
end

setmetatable(lua_store_entrance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_entrance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_entrance, "configList", nil)
	rawset(lua_store_entrance, "configDict", nil)
end

return lua_store_entrance
