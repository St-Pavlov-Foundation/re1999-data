-- chunkname: @modules/configs/excel2json/lua_activity174_bag.lua

module("modules.configs.excel2json.lua_activity174_bag", package.seeall)

local lua_activity174_bag = {}
local fields = {
	season = 3,
	bagDesc = 8,
	costCoin = 6,
	type = 4,
	heroNum = 11,
	heroParam = 10,
	collectionType = 12,
	activityId = 2,
	collectionNum = 14,
	quality = 5,
	heroType = 9,
	enhanceNum = 17,
	collectionParam = 13,
	enhanceType = 15,
	id = 1,
	bagTitle = 7,
	enhanceParam = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	bagDesc = 2,
	bagTitle = 1
}
local _configList, _configDict
local configPath = "configs.activity174_bag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_bag, "configList", _configList)
	rawset(lua_activity174_bag, "configDict", _configDict)
end

setmetatable(lua_activity174_bag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_bag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_bag, "configList", nil)
	rawset(lua_activity174_bag, "configDict", nil)
end

return lua_activity174_bag
