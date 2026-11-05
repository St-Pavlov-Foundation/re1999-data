-- chunkname: @modules/configs/excel2json/lua_character_level.lua

module("modules.configs.excel2json.lua_character_level", package.seeall)

local lua_character_level = {}
local fields = {
	cri_def = 11,
	def = 5,
	technic = 7,
	cri = 8,
	cri_dmg = 10,
	recri = 9,
	mdef = 6,
	drop_dmg = 13,
	add_dmg = 12,
	heroId = 1,
	hp = 3,
	atk = 4,
	level = 2
}
local primaryKey = {
	"heroId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_level, "configList", _configList)
	rawset(lua_character_level, "configDict", _configDict)
end

setmetatable(lua_character_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_level, "configList", nil)
	rawset(lua_character_level, "configDict", nil)
end

return lua_character_level
