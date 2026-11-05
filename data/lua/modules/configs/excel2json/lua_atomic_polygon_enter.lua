-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_enter.lua

module("modules.configs.excel2json.lua_atomic_polygon_enter", package.seeall)

local lua_atomic_polygon_enter = {}
local fields = {
	mapId = 5,
	name = 2,
	id = 1,
	icon = 4,
	pos = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.atomic_polygon_enter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_polygon_enter, "configList", _configList)
	rawset(lua_atomic_polygon_enter, "configDict", _configDict)
end

setmetatable(lua_atomic_polygon_enter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_polygon_enter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_polygon_enter, "configList", nil)
	rawset(lua_atomic_polygon_enter, "configDict", nil)
end

return lua_atomic_polygon_enter
