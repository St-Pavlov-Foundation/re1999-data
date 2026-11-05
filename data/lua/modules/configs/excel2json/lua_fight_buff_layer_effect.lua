-- chunkname: @modules/configs/excel2json/lua_fight_buff_layer_effect.lua

module("modules.configs.excel2json.lua_fight_buff_layer_effect", package.seeall)

local lua_fight_buff_layer_effect = {}
local fields = {
	addLayerEffect = 8,
	lE = 21,
	skin = 2,
	delayTimeBeforeLoop = 15,
	releaseDestroyEffectTime = 19,
	addLayerEffectRoot = 9,
	addLayerAudio = 7,
	destroyEffectAudio = 18,
	destroyEffectRoot = 17,
	destroyEffect = 16,
	releaseAddLayerEffectTime = 10,
	loopEffectAudio = 6,
	createEffect = 11,
	releaseCreateEffectTime = 14,
	loopEffectRoot = 5,
	layer = 3,
	hideEffectWhenBigSkill = 22,
	hideEffectWhenPlaying = 20,
	loopEffect = 4,
	id = 1,
	createAudio = 13,
	createEffectRoot = 12
}
local primaryKey = {
	"id",
	"skin",
	"layer"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_layer_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_layer_effect, "configList", _configList)
	rawset(lua_fight_buff_layer_effect, "configDict", _configDict)
end

setmetatable(lua_fight_buff_layer_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_layer_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_layer_effect, "configList", nil)
	rawset(lua_fight_buff_layer_effect, "configDict", nil)
end

return lua_fight_buff_layer_effect
