-- chunkname: @modules/configs/excel2json/lua_destiny_facets_ex_level.lua

module("modules.configs.excel2json.lua_destiny_facets_ex_level", package.seeall)

local lua_destiny_facets_ex_level = {}
local fields = {
	skillEx = 8,
	passiveSkill = 9,
	desc = 3,
	qteid = 5,
	deviceId = 4,
	skillGroup2 = 7,
	skillGroup1 = 6,
	skillLevel = 2,
	heroId = 1,
	exchangeSkill = 10
}
local primaryKey = {
	"heroId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.destiny_facets_ex_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_destiny_facets_ex_level, "configList", _configList)
	rawset(lua_destiny_facets_ex_level, "configDict", _configDict)
end

setmetatable(lua_destiny_facets_ex_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_destiny_facets_ex_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_destiny_facets_ex_level, "configList", nil)
	rawset(lua_destiny_facets_ex_level, "configDict", nil)
end

return lua_destiny_facets_ex_level
