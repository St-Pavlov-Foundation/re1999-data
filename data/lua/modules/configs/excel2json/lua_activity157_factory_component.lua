-- chunkname: @modules/configs/excel2json/lua_activity157_factory_component.lua

module("modules.configs.excel2json.lua_activity157_factory_component", package.seeall)

local lua_activity157_factory_component = {}
local fields = {
	componentId = 2,
	preComponentId = 4,
	unlockCondition = 3,
	elementId = 6,
	nextComponentId = 5,
	bonusForShow = 8,
	bonusBuildingLevel = 9,
	activityId = 1,
	bonus = 7
}
local primaryKey = {
	"activityId",
	"componentId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity157_factory_component_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity157_factory_component, "configList", _configList)
	rawset(lua_activity157_factory_component, "configDict", _configDict)
end

setmetatable(lua_activity157_factory_component, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity157_factory_component.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity157_factory_component, "configList", nil)
	rawset(lua_activity157_factory_component, "configDict", nil)
end

return lua_activity157_factory_component
