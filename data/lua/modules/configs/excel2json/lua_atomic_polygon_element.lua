-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_element.lua

module("modules.configs.excel2json.lua_atomic_polygon_element", package.seeall)

local lua_atomic_polygon_element = {}
local fields = {
	icon = 6,
	mapId = 2,
	taskDesc = 7,
	type = 4,
	id = 1,
	unlockCondition = 3,
	pos = 5,
	needFollow = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskDesc = 1
}
local _configList, _configDict
local configPath = "configs.atomic_polygon_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_polygon_element, "configList", _configList)
	rawset(lua_atomic_polygon_element, "configDict", _configDict)
end

setmetatable(lua_atomic_polygon_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_polygon_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_polygon_element, "configList", nil)
	rawset(lua_atomic_polygon_element, "configDict", nil)
end

return lua_atomic_polygon_element
