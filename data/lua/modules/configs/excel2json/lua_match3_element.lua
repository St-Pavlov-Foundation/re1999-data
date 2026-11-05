-- chunkname: @modules/configs/excel2json/lua_match3_element.lua

module("modules.configs.excel2json.lua_match3_element", package.seeall)

local lua_match3_element = {}
local fields = {
	elementId = 1,
	name = 3,
	elementKey = 2,
	icon = 5,
	beadColor = 4
}
local primaryKey = {
	"elementId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.match3_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_element, "configList", _configList)
	rawset(lua_match3_element, "configDict", _configDict)
end

setmetatable(lua_match3_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_element, "configList", nil)
	rawset(lua_match3_element, "configDict", nil)
end

return lua_match3_element
