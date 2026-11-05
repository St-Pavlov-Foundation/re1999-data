-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_character.lua

module("modules.configs.excel2json.lua_eliminate_battle_character", package.seeall)

local lua_eliminate_battle_character = {}
local fields = {
	skill = 5,
	name = 2,
	hp = 4,
	specialAttr1 = 6,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.eliminate_battle_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_character, "configList", _configList)
	rawset(lua_eliminate_battle_character, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_character, "configList", nil)
	rawset(lua_eliminate_battle_character, "configDict", nil)
end

return lua_eliminate_battle_character
