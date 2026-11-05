-- chunkname: @modules/configs/excel2json/lua_store_recommend.lua

module("modules.configs.excel2json.lua_store_recommend", package.seeall)

local lua_store_recommend = {}
local fields = {
	systemJumpCode = 16,
	prefab = 4,
	relations = 14,
	adjustOrder = 8,
	name = 2,
	des = 6,
	className = 19,
	showOfflineTime = 13,
	onlineTime = 10,
	type = 17,
	topDay = 20,
	topType = 21,
	isOffline = 9,
	isShowTurnback = 22,
	order = 7,
	isCustomLoad = 18,
	showOnlineTime = 12,
	offlineTime = 11,
	country = 15,
	res = 3,
	id = 1,
	nameEn = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.store_recommend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_recommend, "configList", _configList)
	rawset(lua_store_recommend, "configDict", _configDict)
end

setmetatable(lua_store_recommend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_recommend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_recommend, "configList", nil)
	rawset(lua_store_recommend, "configDict", nil)
end

return lua_store_recommend
