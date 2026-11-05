-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map.lua

module("modules.configs.excel2json.lua_activity220_wmz_map", package.seeall)

local lua_activity220_wmz_map = {}
local fields = {
	guildId = 5,
	zoneId4 = 9,
	mapSizeX = 2,
	zoneId2 = 7,
	maxEnergy = 4,
	zoneId3 = 8,
	id = 1,
	mapSizeY = 3,
	zoneId1 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_wmz_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_wmz_map, "configList", _configList)
	rawset(lua_activity220_wmz_map, "configDict", _configDict)
end

setmetatable(lua_activity220_wmz_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_wmz_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_wmz_map, "configList", nil)
	rawset(lua_activity220_wmz_map, "configDict", nil)
end

return lua_activity220_wmz_map
