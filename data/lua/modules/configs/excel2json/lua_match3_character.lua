-- chunkname: @modules/configs/excel2json/lua_match3_character.lua

module("modules.configs.excel2json.lua_match3_character", package.seeall)

local lua_match3_character = {}
local fields = {
	baseDef = 7,
	baseHeal = 8,
	baseHp = 6,
	baseAtk = 5,
	name = 2,
	image = 11,
	levelTplId = 4,
	costItemId = 13,
	elementId = 3,
	unlockType = 12,
	characterId = 1,
	icon = 10,
	activeSkillId = 9
}
local primaryKey = {
	"characterId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.match3_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_character, "configList", _configList)
	rawset(lua_match3_character, "configDict", _configDict)
end

setmetatable(lua_match3_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_character, "configList", nil)
	rawset(lua_match3_character, "configDict", nil)
end

return lua_match3_character
