-- chunkname: @modules/configs/excel2json/lua_activity244_character.lua

module("modules.configs.excel2json.lua_activity244_character", package.seeall)

local lua_activity244_character = {}
local fields = {
	baseDef = 7,
	baseHeal = 8,
	baseHp = 6,
	baseAtk = 5,
	name = 2,
	image = 11,
	mesh = 12,
	levelTplId = 4,
	elementId = 3,
	unlockType = 13,
	isTrial = 14,
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
local configPath = "configs.activity244_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_character, "configList", _configList)
	rawset(lua_activity244_character, "configDict", _configDict)
end

setmetatable(lua_activity244_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_character, "configList", nil)
	rawset(lua_activity244_character, "configDict", nil)
end

return lua_activity244_character
