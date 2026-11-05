-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_kkny_bear_damage.lua

module("modules.configs.excel2json.lua_fight_sp_effect_kkny_bear_damage", package.seeall)

local lua_fight_sp_effect_kkny_bear_damage = {}
local fields = {
	id = 1,
	hangPoint = 3,
	audio = 4,
	path = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_kkny_bear_damage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_kkny_bear_damage, "configList", _configList)
	rawset(lua_fight_sp_effect_kkny_bear_damage, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_kkny_bear_damage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_kkny_bear_damage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_kkny_bear_damage, "configList", nil)
	rawset(lua_fight_sp_effect_kkny_bear_damage, "configDict", nil)
end

return lua_fight_sp_effect_kkny_bear_damage
