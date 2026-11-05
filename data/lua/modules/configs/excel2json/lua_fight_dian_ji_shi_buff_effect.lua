-- chunkname: @modules/configs/excel2json/lua_fight_dian_ji_shi_buff_effect.lua

module("modules.configs.excel2json.lua_fight_dian_ji_shi_buff_effect", package.seeall)

local lua_fight_dian_ji_shi_buff_effect = {}
local fields = {
	initEffectHang = 8,
	priority = 3,
	effectHang = 5,
	effect = 4,
	chargeEffect = 10,
	initEffectDuration = 9,
	buffTypeId = 2,
	chargeEffectDuration = 12,
	audioId = 6,
	initEffect = 7,
	chargeAudioId = 13,
	id = 1,
	chargeEffectHang = 11
}
local primaryKey = {
	"id",
	"buffTypeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_dian_ji_shi_buff_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_dian_ji_shi_buff_effect, "configList", _configList)
	rawset(lua_fight_dian_ji_shi_buff_effect, "configDict", _configDict)
end

setmetatable(lua_fight_dian_ji_shi_buff_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_dian_ji_shi_buff_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_dian_ji_shi_buff_effect, "configList", nil)
	rawset(lua_fight_dian_ji_shi_buff_effect, "configDict", nil)
end

return lua_fight_dian_ji_shi_buff_effect
