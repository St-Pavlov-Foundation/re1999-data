-- chunkname: @modules/configs/excel2json/lua_activity149_map_element.lua

module("modules.configs.excel2json.lua_activity149_map_element", package.seeall)

local lua_activity149_map_element = {}
local fields = {
	mapId = 2,
	res = 4,
	tipOffsetPos = 6,
	effect = 7,
	id = 1,
	pos = 3,
	resScale = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity149_map_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity149_map_element, "configList", _configList)
	rawset(lua_activity149_map_element, "configDict", _configDict)
end

setmetatable(lua_activity149_map_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity149_map_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity149_map_element, "configList", nil)
	rawset(lua_activity149_map_element, "configDict", nil)
end

return lua_activity149_map_element
