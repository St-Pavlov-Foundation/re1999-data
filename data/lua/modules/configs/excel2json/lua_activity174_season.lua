-- chunkname: @modules/configs/excel2json/lua_activity174_season.lua

module("modules.configs.excel2json.lua_activity174_season", package.seeall)

local lua_activity174_season = {}
local fields = {
	openTime = 3,
	name = 4,
	season = 1,
	activityId = 2,
	desc = 5
}
local primaryKey = {
	"season"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity174_season_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_season, "configList", _configList)
	rawset(lua_activity174_season, "configDict", _configDict)
end

setmetatable(lua_activity174_season, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_season.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_season, "configList", nil)
	rawset(lua_activity174_season, "configDict", nil)
end

return lua_activity174_season
