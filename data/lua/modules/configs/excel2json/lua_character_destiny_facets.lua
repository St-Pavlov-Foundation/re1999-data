-- chunkname: @modules/configs/excel2json/lua_character_destiny_facets.lua

module("modules.configs.excel2json.lua_character_destiny_facets", package.seeall)

local lua_character_destiny_facets = {}
local fields = {
	exchangeSkills = 7,
	facetsId = 1,
	uniqueSkill_point = 4,
	desc = 8,
	ex_level_exchange = 9,
	deviceAdd = 5,
	powerAdd = 3,
	qteAdd = 6,
	level = 2
}
local primaryKey = {
	"facetsId",
	"level"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.character_destiny_facets_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_destiny_facets, "configList", _configList)
	rawset(lua_character_destiny_facets, "configDict", _configDict)
end

setmetatable(lua_character_destiny_facets, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_destiny_facets.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_destiny_facets, "configList", nil)
	rawset(lua_character_destiny_facets, "configDict", nil)
end

return lua_character_destiny_facets
