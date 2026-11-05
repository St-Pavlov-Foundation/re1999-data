-- chunkname: @modules/configs/excel2json/lua_activity101_doublefestival.lua

module("modules.configs.excel2json.lua_activity101_doublefestival", package.seeall)

local lua_activity101_doublefestival = {}
local fields = {
	blessTitle = 5,
	blessContent = 7,
	blessTitleEn = 6,
	btnDesc = 4,
	blessDesc = 8,
	blessContentType = 10,
	day = 2,
	bgSpriteName = 3,
	activityId = 1,
	blessSpriteName = 9
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	btnDesc = 2,
	bgSpriteName = 1,
	blessContent = 5,
	blessDesc = 6,
	blessTitle = 3,
	blessContentType = 8,
	blessTitleEn = 4,
	blessSpriteName = 7
}
local _configList, _configDict
local configPath = "configs.activity101_doublefestival_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity101_doublefestival, "configList", _configList)
	rawset(lua_activity101_doublefestival, "configDict", _configDict)
end

setmetatable(lua_activity101_doublefestival, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity101_doublefestival.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity101_doublefestival, "configList", nil)
	rawset(lua_activity101_doublefestival, "configDict", nil)
end

return lua_activity101_doublefestival
