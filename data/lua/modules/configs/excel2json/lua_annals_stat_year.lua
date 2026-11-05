-- chunkname: @modules/configs/excel2json/lua_annals_stat_year.lua

module("modules.configs.excel2json.lua_annals_stat_year", package.seeall)

local lua_annals_stat_year = {}
local fields = {
	endTime = 3,
	year = 1,
	startTime = 2
}
local primaryKey = {
	"year"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.annals_stat_year_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_annals_stat_year, "configList", _configList)
	rawset(lua_annals_stat_year, "configDict", _configDict)
end

setmetatable(lua_annals_stat_year, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_annals_stat_year.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_annals_stat_year, "configList", nil)
	rawset(lua_annals_stat_year, "configDict", nil)
end

return lua_annals_stat_year
