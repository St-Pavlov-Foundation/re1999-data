-- chunkname: @modules/configs/excel2json/lua_activity125.lua

module("modules.configs.excel2json.lua_activity125", package.seeall)

local lua_activity125 = {}
local fields = {
	clientbonus = 12,
	key = 15,
	taskId = 5,
	musictime = 13,
	groupId = 17,
	name = 9,
	targetFrequency = 8,
	sourceid = 16,
	text = 10,
	preId = 3,
	initFrequency = 7,
	activityId = 1,
	openDay = 4,
	time = 14,
	id = 2,
	frequency = 6,
	bonus = 11
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity125_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity125, "configList", _configList)
	rawset(lua_activity125, "configDict", _configDict)
end

setmetatable(lua_activity125, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity125.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity125, "configList", nil)
	rawset(lua_activity125, "configDict", nil)
end

return lua_activity125
