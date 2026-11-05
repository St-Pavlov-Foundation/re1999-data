-- chunkname: @modules/configs/excel2json/lua_activity244_character_level.lua

module("modules.configs.excel2json.lua_activity244_character_level", package.seeall)

local lua_activity244_character_level = {}
local fields = {
	needItem = 4,
	levelTplId = 2,
	hpAdd = 6,
	defAdd = 7,
	id = 1,
	atkAdd = 5,
	healAdd = 8,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_character_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_character_level, "configList", _configList)
	rawset(lua_activity244_character_level, "configDict", _configDict)
end

setmetatable(lua_activity244_character_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_character_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_character_level, "configList", nil)
	rawset(lua_activity244_character_level, "configDict", nil)
end

return lua_activity244_character_level
