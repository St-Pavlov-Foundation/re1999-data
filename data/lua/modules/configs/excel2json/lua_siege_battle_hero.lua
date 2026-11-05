-- chunkname: @modules/configs/excel2json/lua_siege_battle_hero.lua

module("modules.configs.excel2json.lua_siege_battle_hero", package.seeall)

local lua_siege_battle_hero = {}
local fields = {
	param = 5,
	name = 2,
	type = 4,
	id = 1,
	icon = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.siege_battle_hero_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_siege_battle_hero, "configList", _configList)
	rawset(lua_siege_battle_hero, "configDict", _configDict)
end

setmetatable(lua_siege_battle_hero, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_siege_battle_hero.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_siege_battle_hero, "configList", nil)
	rawset(lua_siege_battle_hero, "configDict", nil)
end

return lua_siege_battle_hero
