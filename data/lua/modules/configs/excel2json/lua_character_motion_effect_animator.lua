-- chunkname: @modules/configs/excel2json/lua_character_motion_effect_animator.lua

module("modules.configs.excel2json.lua_character_motion_effect_animator", package.seeall)

local lua_character_motion_effect_animator = {}
local fields = {
	defaultState = 3,
	effectNode = 2,
	delay = 5,
	stateList = 4,
	heroResName = 1
}
local primaryKey = {
	"heroResName",
	"effectNode"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_motion_effect_animator_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_motion_effect_animator, "configList", _configList)
	rawset(lua_character_motion_effect_animator, "configDict", _configDict)
end

setmetatable(lua_character_motion_effect_animator, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_motion_effect_animator.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_motion_effect_animator, "configList", nil)
	rawset(lua_character_motion_effect_animator, "configDict", nil)
end

return lua_character_motion_effect_animator
