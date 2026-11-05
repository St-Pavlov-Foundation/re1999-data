-- chunkname: @modules/configs/excel2json/lua_activity108_map.lua

module("modules.configs.excel2json.lua_activity108_map", package.seeall)

local lua_activity108_map = {}
local fields = {
	cookie = 16,
	actContent = 13,
	endContent = 18,
	threat = 7,
	cookieContent = 17,
	title = 11,
	content = 12,
	offlineDay = 6,
	exhibits = 8,
	monsterIcon = 9,
	enemyTitle = 14,
	activityId = 4,
	enemyInfo = 15,
	preId = 2,
	onlineDay = 5,
	id = 1,
	consignor = 10,
	initScore = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 2,
	cookieContent = 7,
	actContent = 4,
	endContent = 8,
	enemyTitle = 5,
	consignor = 1,
	content = 3,
	enemyInfo = 6
}
local _configList, _configDict
local configPath = "configs.activity108_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_map, "configList", _configList)
	rawset(lua_activity108_map, "configDict", _configDict)
end

setmetatable(lua_activity108_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_map, "configList", nil)
	rawset(lua_activity108_map, "configDict", nil)
end

return lua_activity108_map
