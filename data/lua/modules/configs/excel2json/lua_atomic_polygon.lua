-- chunkname: @modules/configs/excel2json/lua_atomic_polygon.lua

module("modules.configs.excel2json.lua_atomic_polygon", package.seeall)

local lua_atomic_polygon = {}
local fields = {
	mapId = 2,
	name = 4,
	icon = 5,
	id = 1,
	unlockCondition = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.atomic_polygon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_polygon, "configList", _configList)
	rawset(lua_atomic_polygon, "configDict", _configDict)
end

setmetatable(lua_atomic_polygon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_polygon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_polygon, "configList", nil)
	rawset(lua_atomic_polygon, "configDict", nil)
end

return lua_atomic_polygon
