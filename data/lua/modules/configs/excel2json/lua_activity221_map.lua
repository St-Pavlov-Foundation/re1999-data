-- chunkname: @modules/configs/excel2json/lua_activity221_map.lua

module("modules.configs.excel2json.lua_activity221_map", package.seeall)

local lua_activity221_map = {}
local fields = {
	mapId = 1,
	time = 2,
	targets = 3,
	type7Weight = 5,
	targetDesc = 4
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity221_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity221_map, "configList", _configList)
	rawset(lua_activity221_map, "configDict", _configDict)
end

setmetatable(lua_activity221_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity221_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity221_map, "configList", nil)
	rawset(lua_activity221_map, "configDict", nil)
end

return lua_activity221_map
