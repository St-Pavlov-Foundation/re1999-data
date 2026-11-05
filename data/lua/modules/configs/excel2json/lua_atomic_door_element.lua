-- chunkname: @modules/configs/excel2json/lua_atomic_door_element.lua

module("modules.configs.excel2json.lua_atomic_door_element", package.seeall)

local lua_atomic_door_element = {}
local fields = {
	keyElementIds = 2,
	title = 3,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.atomic_door_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_door_element, "configList", _configList)
	rawset(lua_atomic_door_element, "configDict", _configDict)
end

setmetatable(lua_atomic_door_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_door_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_door_element, "configList", nil)
	rawset(lua_atomic_door_element, "configDict", nil)
end

return lua_atomic_door_element
