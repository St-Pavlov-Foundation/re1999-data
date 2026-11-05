-- chunkname: @modules/configs/excel2json/lua_character_destiny_facets_consume.lua

module("modules.configs.excel2json.lua_character_destiny_facets_consume", package.seeall)

local lua_character_destiny_facets_consume = {}
local fields = {
	facetsSort = 6,
	name = 2,
	facetsId = 1,
	type = 8,
	titleName = 9,
	tend = 4,
	keyword = 7,
	consume = 3,
	tag = 10,
	icon = 5
}
local primaryKey = {
	"facetsId"
}
local mlStringKey = {
	titleName = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.character_destiny_facets_consume_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_destiny_facets_consume, "configList", _configList)
	rawset(lua_character_destiny_facets_consume, "configDict", _configDict)
end

setmetatable(lua_character_destiny_facets_consume, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_destiny_facets_consume.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_destiny_facets_consume, "configList", nil)
	rawset(lua_character_destiny_facets_consume, "configDict", nil)
end

return lua_character_destiny_facets_consume
