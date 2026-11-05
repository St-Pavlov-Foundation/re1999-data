-- chunkname: @modules/configs/excel2json/lua_tower_compose_point.lua

module("modules.configs.excel2json.lua_tower_compose_point", package.seeall)

local lua_tower_compose_point = {}
local fields = {
	bossPointBase = 4,
	bossPointAdd = 5,
	id = 1,
	round = 3,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_compose_point_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_point, "configList", _configList)
	rawset(lua_tower_compose_point, "configDict", _configDict)
end

setmetatable(lua_tower_compose_point, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_point.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_point, "configList", nil)
	rawset(lua_tower_compose_point, "configDict", nil)
end

return lua_tower_compose_point
