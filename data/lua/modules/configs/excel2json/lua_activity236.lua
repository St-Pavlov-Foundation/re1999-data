-- chunkname: @modules/configs/excel2json/lua_activity236.lua

module("modules.configs.excel2json.lua_activity236", package.seeall)

local lua_activity236 = {}
local fields = {
	reward = 4,
	cost = 3,
	showVideo = 7,
	showWindow = 6,
	id = 1,
	activityId = 2,
	showReward = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	showVideo = 3,
	showWindow = 2,
	showReward = 1
}
local _configList, _configDict
local configPath = "configs.activity236_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity236, "configList", _configList)
	rawset(lua_activity236, "configDict", _configDict)
end

setmetatable(lua_activity236, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity236.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity236, "configList", nil)
	rawset(lua_activity236, "configDict", nil)
end

return lua_activity236
