-- chunkname: @modules/configs/excel2json/lua_activity114_travel.lua

module("modules.configs.excel2json.lua_activity114_travel", package.seeall)

local lua_activity114_travel = {}
local fields = {
	specialEvents = 8,
	placeEn = 4,
	condition = 7,
	residentEvent = 6,
	id = 2,
	events = 5,
	activityId = 1,
	place = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	place = 1
}
local _configList, _configDict
local configPath = "configs.activity114_travel_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_travel, "configList", _configList)
	rawset(lua_activity114_travel, "configDict", _configDict)
end

setmetatable(lua_activity114_travel, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_travel.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_travel, "configList", nil)
	rawset(lua_activity114_travel, "configDict", nil)
end

return lua_activity114_travel
