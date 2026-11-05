-- chunkname: @modules/configs/excel2json/lua_tower_compose_point_level.lua

module("modules.configs.excel2json.lua_tower_compose_point_level", package.seeall)

local lua_tower_compose_point_level = {}
local fields = {
	bossPointBase = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_compose_point_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_point_level, "configList", _configList)
	rawset(lua_tower_compose_point_level, "configDict", _configDict)
end

setmetatable(lua_tower_compose_point_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_point_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_point_level, "configList", nil)
	rawset(lua_tower_compose_point_level, "configDict", nil)
end

return lua_tower_compose_point_level
