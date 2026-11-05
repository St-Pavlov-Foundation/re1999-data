-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_character.lua

module("modules.configs.excel2json.lua_arcade_survivor_character", package.seeall)

local lua_arcade_survivor_character = {}
local fields = {
	atkWidth = 11,
	name = 2,
	atkLength = 10,
	collectionId = 5,
	dodgeRate = 17,
	unlockCondition = 19,
	respawnNeedHpCap = 18,
	desc = 3,
	lockTip = 20,
	criDmgRate = 16,
	hpCap = 7,
	atk = 8,
	charTag = 21,
	icon = 23,
	icon2Offset2 = 29,
	dmgAddRate = 14,
	portrait = 24,
	portraitScale = 25,
	atkShape = 9,
	hpPos = 30,
	posOffset = 28,
	resName = 22,
	portraitOffset = 26,
	atkCount = 13,
	weaponCollectionId = 4,
	criRate = 15,
	atkInterval = 12,
	id = 1,
	shape = 6,
	scale = 27
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lockTip = 3,
	name = 1,
	charTag = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_character, "configList", _configList)
	rawset(lua_arcade_survivor_character, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_character, "configList", nil)
	rawset(lua_arcade_survivor_character, "configDict", nil)
end

return lua_arcade_survivor_character
