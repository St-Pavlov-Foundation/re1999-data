-- chunkname: @modules/configs/excel2json/lua_activity128_season.lua

module("modules.configs.excel2json.lua_activity128_season", package.seeall)

local lua_activity128_season = {}
local fields = {
	id = 1,
	expMaterial = 2,
	name = 3,
	nameLevel = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameLevel = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity128_season_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_season, "configList", _configList)
	rawset(lua_activity128_season, "configDict", _configDict)
end

setmetatable(lua_activity128_season, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_season.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_season, "configList", nil)
	rawset(lua_activity128_season, "configDict", nil)
end

return lua_activity128_season
