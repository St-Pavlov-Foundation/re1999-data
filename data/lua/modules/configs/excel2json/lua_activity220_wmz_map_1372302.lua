-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map_1372302.lua

module("modules.configs.excel2json.lua_activity220_wmz_map_1372302", package.seeall)

local lua_activity220_wmz_map_1372302 = {}
local fields = {
	fromX = 2,
	content = 6,
	toX = 4,
	id = 1,
	toY = 5,
	fromY = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_wmz_map_1372302_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_wmz_map_1372302, "configList", _configList)
	rawset(lua_activity220_wmz_map_1372302, "configDict", _configDict)
end

setmetatable(lua_activity220_wmz_map_1372302, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_wmz_map_1372302.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_wmz_map_1372302, "configList", nil)
	rawset(lua_activity220_wmz_map_1372302, "configDict", nil)
end

return lua_activity220_wmz_map_1372302
