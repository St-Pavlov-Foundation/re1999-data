-- chunkname: @modules/configs/excel2json/lua_activity101.lua

module("modules.configs.excel2json.lua_activity101", package.seeall)

local lua_activity101 = {}
local fields = {
	isnotPush = 4,
	sourceid = 5,
	v2Bonus = 6,
	clientDisplayTxt = 8,
	id = 2,
	clientDisplayType = 7,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity101_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity101, "configList", _configList)
	rawset(lua_activity101, "configDict", _configDict)
end

setmetatable(lua_activity101, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity101.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity101, "configList", nil)
	rawset(lua_activity101, "configDict", nil)
end

return lua_activity101
