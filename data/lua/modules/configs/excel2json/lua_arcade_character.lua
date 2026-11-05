-- chunkname: @modules/configs/excel2json/lua_arcade_character.lua

module("modules.configs.excel2json.lua_arcade_character", package.seeall)

local lua_arcade_character = {}
local fields = {
	defense = 5,
	name = 2,
	collection = 9,
	hpCap = 4,
	icon2Offset = 18,
	icon = 15,
	id = 1,
	desc = 20,
	icon2Offset2 = 19,
	skill = 7,
	attack = 3,
	bomb = 8,
	resPath = 11,
	hpPos = 13,
	skillCost = 6,
	icon2Scale = 17,
	lockTip = 21,
	category = 14,
	icon2 = 16,
	shape = 10,
	scale = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lockTip = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.arcade_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_character, "configList", _configList)
	rawset(lua_arcade_character, "configDict", _configDict)
end

setmetatable(lua_arcade_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_character, "configList", nil)
	rawset(lua_arcade_character, "configDict", nil)
end

return lua_arcade_character
