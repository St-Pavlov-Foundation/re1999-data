-- chunkname: @modules/configs/excel2json/lua_dice_character.lua

module("modules.configs.excel2json.lua_dice_character", package.seeall)

local lua_dice_character = {}
local fields = {
	relicIds = 7,
	name = 2,
	dicelist = 5,
	skilllist = 6,
	power = 10,
	resetTimes = 8,
	powerSkill = 11,
	desc = 3,
	hp = 9,
	id = 1,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.dice_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_character, "configList", _configList)
	rawset(lua_dice_character, "configDict", _configDict)
end

setmetatable(lua_dice_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_character, "configList", nil)
	rawset(lua_dice_character, "configDict", nil)
end

return lua_dice_character
