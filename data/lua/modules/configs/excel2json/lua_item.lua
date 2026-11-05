-- chunkname: @modules/configs/excel2json/lua_item.lua

module("modules.configs.excel2json.lua_item", package.seeall)

local lua_item = {}
local fields = {
	isTimeShow = 12,
	name = 2,
	cd = 15,
	isShow = 11,
	boxOpen = 20,
	activityId = 18,
	sources = 19,
	desc = 4,
	rare = 8,
	subType = 5,
	clientDisplayType = 23,
	itemSortIdx = 21,
	icon = 7,
	price = 17,
	expireTime = 16,
	effect = 14,
	useDesc = 3,
	headIconSign = 22,
	clienttag = 6,
	id = 1,
	isStackable = 10,
	isDynamic = 13,
	highQuality = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_item, "configList", _configList)
	rawset(lua_item, "configDict", _configDict)
end

setmetatable(lua_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_item, "configList", nil)
	rawset(lua_item, "configDict", nil)
end

return lua_item
