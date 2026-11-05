-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti.lua

module("modules.configs.excel2json.lua_activity161_graffiti", package.seeall)

local lua_activity161_graffiti = {}
local fields = {
	dialogGroupId = 7,
	subElementIds = 6,
	activityId = 1,
	finishRate = 9,
	mainElementCd = 5,
	picture = 8,
	finishTitle = 12,
	finishDesc = 13,
	elementId = 2,
	preMainElementIds = 4,
	finishTitleEn = 14,
	brushSize = 10,
	mainElementId = 3,
	sort = 11
}
local primaryKey = {
	"activityId",
	"elementId"
}
local mlStringKey = {
	finishDesc = 2,
	finishTitle = 1
}
local _configList, _configDict
local configPath = "configs.activity161_graffiti_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity161_graffiti, "configList", _configList)
	rawset(lua_activity161_graffiti, "configDict", _configDict)
end

setmetatable(lua_activity161_graffiti, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity161_graffiti.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity161_graffiti, "configList", nil)
	rawset(lua_activity161_graffiti, "configDict", nil)
end

return lua_activity161_graffiti
