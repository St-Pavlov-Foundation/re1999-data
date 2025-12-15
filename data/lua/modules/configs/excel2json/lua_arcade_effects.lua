-- chunkname: @modules/configs/excel2json/lua_arcade_effects.lua

module("modules.configs.excel2json.lua_arcade_effects", package.seeall)

local lua_arcade_effects = {}
local fields = {
	triggerAudio = 3,
	triggerEffects = 4,
	effectsOffset = 10,
	isFromBorder = 8,
	effectsScale = 11,
	effectsRotationType = 9,
	needShake = 12,
	triggerAnimation = 2,
	speed = 6,
	direction = 7,
	id = 1,
	isPlayOnGrid = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_effects.onLoad(json)
	lua_arcade_effects.configList, lua_arcade_effects.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_effects
