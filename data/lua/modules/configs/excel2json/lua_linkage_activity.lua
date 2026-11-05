-- chunkname: @modules/configs/excel2json/lua_linkage_activity.lua

module("modules.configs.excel2json.lua_linkage_activity", package.seeall)

local lua_linkage_activity = {}
local fields = {
	item1 = 7,
	activityId = 1,
	showOnlineTime = 2,
	desc1 = 9,
	item2 = 8,
	showOfflineTime = 3,
	res_video2 = 5,
	desc2 = 10,
	res_video1 = 4,
	systemJumpCode = 6
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {
	desc2 = 2,
	desc1 = 1
}
local _configList, _configDict
local configPath = "configs.linkage_activity_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_linkage_activity, "configList", _configList)
	rawset(lua_linkage_activity, "configDict", _configDict)
end

setmetatable(lua_linkage_activity, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_linkage_activity.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_linkage_activity, "configList", nil)
	rawset(lua_linkage_activity, "configDict", nil)
end

return lua_linkage_activity
