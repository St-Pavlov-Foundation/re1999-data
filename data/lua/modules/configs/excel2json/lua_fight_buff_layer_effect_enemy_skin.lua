-- chunkname: @modules/configs/excel2json/lua_fight_buff_layer_effect_enemy_skin.lua

module("modules.configs.excel2json.lua_fight_buff_layer_effect_enemy_skin", package.seeall)

local lua_fight_buff_layer_effect_enemy_skin = {}
local fields = {
	releaseCreateEffectTime = 15,
	addLayerEffectRoot = 10,
	hideWhenPlayTimeline = 6,
	delayTimeBeforeLoop = 16,
	releaseDestroyEffectTime = 20,
	skin = 2,
	addLayerAudio = 8,
	destroyEffect = 17,
	destroyEffectRoot = 18,
	addLayerEffect = 9,
	releaseAddLayerEffectTime = 11,
	destroyEffectAudio = 19,
	createEffect = 12,
	loopEffectAudio = 7,
	loopEffectRoot = 5,
	layer = 3,
	loopEffect = 4,
	id = 1,
	createAudio = 14,
	createEffectRoot = 13
}
local primaryKey = {
	"id",
	"skin",
	"layer"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_layer_effect_enemy_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_layer_effect_enemy_skin, "configList", _configList)
	rawset(lua_fight_buff_layer_effect_enemy_skin, "configDict", _configDict)
end

setmetatable(lua_fight_buff_layer_effect_enemy_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_layer_effect_enemy_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_layer_effect_enemy_skin, "configList", nil)
	rawset(lua_fight_buff_layer_effect_enemy_skin, "configDict", nil)
end

return lua_fight_buff_layer_effect_enemy_skin
