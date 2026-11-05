-- chunkname: @modules/configs/excel2json/lua_activity220_peishita_map.lua

module("modules.configs.excel2json.lua_activity220_peishita_map", package.seeall)

local lua_activity220_peishita_map = {}
local fields = {
	bg = 2,
	mapId = 1,
	bgContent = 3
}
local primaryKey = {
	"mapId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_peishita_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_peishita_map, "configList", _configList)
	rawset(lua_activity220_peishita_map, "configDict", _configDict)
end

setmetatable(lua_activity220_peishita_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_peishita_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_peishita_map, "configList", nil)
	rawset(lua_activity220_peishita_map, "configDict", nil)
end

return lua_activity220_peishita_map
