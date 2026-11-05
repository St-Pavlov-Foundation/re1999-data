-- chunkname: @modules/configs/excel2json/lua_activity123_package.lua

module("modules.configs.excel2json.lua_activity123_package", package.seeall)

local lua_activity123_package = {}
local fields = {
	id = 2,
	name = 3,
	changeWeight = 7,
	awardTime5 = 6,
	initWeight = 4,
	awardTime4 = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity123_package_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_package, "configList", _configList)
	rawset(lua_activity123_package, "configDict", _configDict)
end

setmetatable(lua_activity123_package, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_package.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_package, "configList", nil)
	rawset(lua_activity123_package, "configDict", nil)
end

return lua_activity123_package
