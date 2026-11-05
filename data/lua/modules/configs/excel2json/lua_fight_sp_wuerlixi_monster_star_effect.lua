-- chunkname: @modules/configs/excel2json/lua_fight_sp_wuerlixi_monster_star_effect.lua

module("modules.configs.excel2json.lua_fight_sp_wuerlixi_monster_star_effect", package.seeall)

local lua_fight_sp_wuerlixi_monster_star_effect = {}
local fields = {
	bornEffectDuration = 5,
	effect = 2,
	buffId = 1,
	disAppearEffectDuration = 7,
	disAppearEffect = 6,
	bornEffect = 4,
	height = 3
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_wuerlixi_monster_star_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_wuerlixi_monster_star_effect, "configList", _configList)
	rawset(lua_fight_sp_wuerlixi_monster_star_effect, "configDict", _configDict)
end

setmetatable(lua_fight_sp_wuerlixi_monster_star_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_wuerlixi_monster_star_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_wuerlixi_monster_star_effect, "configList", nil)
	rawset(lua_fight_sp_wuerlixi_monster_star_effect, "configDict", nil)
end

return lua_fight_sp_wuerlixi_monster_star_effect
