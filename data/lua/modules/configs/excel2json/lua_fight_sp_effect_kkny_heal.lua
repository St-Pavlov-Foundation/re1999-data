-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_kkny_heal.lua

module("modules.configs.excel2json.lua_fight_sp_effect_kkny_heal", package.seeall)

local lua_fight_sp_effect_kkny_heal = {}
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
local configPath = "configs.fight_sp_effect_kkny_heal_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_kkny_heal, "configList", _configList)
	rawset(lua_fight_sp_effect_kkny_heal, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_kkny_heal, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_kkny_heal.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_kkny_heal, "configList", nil)
	rawset(lua_fight_sp_effect_kkny_heal, "configDict", nil)
end

return lua_fight_sp_effect_kkny_heal
