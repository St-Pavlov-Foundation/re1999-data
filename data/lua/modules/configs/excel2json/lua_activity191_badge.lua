-- chunkname: @modules/configs/excel2json/lua_activity191_badge.lua

module("modules.configs.excel2json.lua_activity191_badge", package.seeall)

local lua_activity191_badge = {}
local fields = {
	trigger = 6,
	name = 3,
	actParam = 7,
	spParam = 8,
	id = 2,
	icon = 5,
	activityId = 1,
	desc = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_badge_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_badge, "configList", _configList)
	rawset(lua_activity191_badge, "configDict", _configDict)
end

setmetatable(lua_activity191_badge, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_badge.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_badge, "configList", nil)
	rawset(lua_activity191_badge, "configDict", nil)
end

return lua_activity191_badge
