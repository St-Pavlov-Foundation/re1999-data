-- chunkname: @modules/configs/excel2json/lua_arcade_effects.lua

module("modules.configs.excel2json.lua_arcade_effects", package.seeall)

local lua_arcade_effects = {}
local fields = {
	triggerAudio = 3,
	isNearestGrid = 6,
	triggerEffects = 4,
	isFromBorder = 9,
	effectsOffset = 11,
	effectsRotationType = 10,
	effectsScale = 12,
	triggerAnimation = 2,
	speed = 7,
	needShake = 13,
	direction = 8,
	uiEffect = 14,
	id = 1,
	isPlayOnGrid = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_effects_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_effects, "configList", _configList)
	rawset(lua_arcade_effects, "configDict", _configDict)
end

setmetatable(lua_arcade_effects, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_effects.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_effects, "configList", nil)
	rawset(lua_arcade_effects, "configDict", nil)
end

return lua_arcade_effects
