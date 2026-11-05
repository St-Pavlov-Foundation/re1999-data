-- chunkname: @modules/configs/excel2json/lua_activity220_dianjishi_map.lua

module("modules.configs.excel2json.lua_activity220_dianjishi_map", package.seeall)

local lua_activity220_dianjishi_map = {}
local fields = {
	id = 2,
	mapId = 1,
	direction = 6,
	icon = 5,
	value = 3,
	position = 4,
	offset = 7
}
local primaryKey = {
	"mapId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_dianjishi_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_dianjishi_map, "configList", _configList)
	rawset(lua_activity220_dianjishi_map, "configDict", _configDict)
end

setmetatable(lua_activity220_dianjishi_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_dianjishi_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_dianjishi_map, "configList", nil)
	rawset(lua_activity220_dianjishi_map, "configDict", nil)
end

return lua_activity220_dianjishi_map
