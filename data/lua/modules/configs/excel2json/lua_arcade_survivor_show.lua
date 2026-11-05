-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_show.lua

module("modules.configs.excel2json.lua_arcade_survivor_show", package.seeall)

local lua_arcade_survivor_show = {}
local fields = {
	uiEffect = 15,
	isNearestGrid = 10,
	isFromBorder = 13,
	effectsScale = 7,
	effectsOffset = 6,
	triggerShowMode = 16,
	triggerAudio = 3,
	triggerEffects = 4,
	direction = 12,
	duration = 5,
	needShake = 14,
	effectsRotationType = 8,
	triggerAnimation = 2,
	speed = 11,
	id = 1,
	triggershowModeParam = 17,
	isPlayOnGrid = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_show, "configList", _configList)
	rawset(lua_arcade_survivor_show, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_show, "configList", nil)
	rawset(lua_arcade_survivor_show, "configDict", nil)
end

return lua_arcade_survivor_show
