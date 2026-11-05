-- chunkname: @modules/configs/excel2json/lua_activity244_element.lua

module("modules.configs.excel2json.lua_activity244_element", package.seeall)

local lua_activity244_element = {}
local fields = {
	param = 3,
	name = 4,
	elementId = 1,
	type = 2,
	icon = 5
}
local primaryKey = {
	"elementId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity244_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_element, "configList", _configList)
	rawset(lua_activity244_element, "configDict", _configDict)
end

setmetatable(lua_activity244_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_element, "configList", nil)
	rawset(lua_activity244_element, "configDict", nil)
end

return lua_activity244_element
