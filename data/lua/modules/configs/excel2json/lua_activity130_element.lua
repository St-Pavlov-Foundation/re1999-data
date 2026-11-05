-- chunkname: @modules/configs/excel2json/lua_activity130_element.lua

module("modules.configs.excel2json.lua_activity130_element", package.seeall)

local lua_activity130_element = {}
local fields = {
	param = 4,
	res = 6,
	elementId = 2,
	type = 3,
	activityId = 1,
	skipFinish = 5
}
local primaryKey = {
	"activityId",
	"elementId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity130_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity130_element, "configList", _configList)
	rawset(lua_activity130_element, "configDict", _configDict)
end

setmetatable(lua_activity130_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity130_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity130_element, "configList", nil)
	rawset(lua_activity130_element, "configDict", nil)
end

return lua_activity130_element
