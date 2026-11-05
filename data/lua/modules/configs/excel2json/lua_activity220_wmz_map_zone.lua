-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map_zone.lua

module("modules.configs.excel2json.lua_activity220_wmz_map_zone", package.seeall)

local lua_activity220_wmz_map_zone = {}
local fields = {
	frameFocusX = 7,
	frameBgResName = 6,
	frameFocusY = 8,
	focusY = 10,
	titleDesc = 3,
	titlePosX = 4,
	bgResName = 2,
	id = 1,
	titlePosY = 5,
	focusX = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	titleDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_wmz_map_zone_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_wmz_map_zone, "configList", _configList)
	rawset(lua_activity220_wmz_map_zone, "configDict", _configDict)
end

setmetatable(lua_activity220_wmz_map_zone, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_wmz_map_zone.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_wmz_map_zone, "configList", nil)
	rawset(lua_activity220_wmz_map_zone, "configDict", nil)
end

return lua_activity220_wmz_map_zone
