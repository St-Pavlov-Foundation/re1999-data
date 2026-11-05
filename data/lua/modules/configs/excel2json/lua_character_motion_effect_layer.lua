-- chunkname: @modules/configs/excel2json/lua_character_motion_effect_layer.lua

module("modules.configs.excel2json.lua_character_motion_effect_layer", package.seeall)

local lua_character_motion_effect_layer = {}
local fields = {
	node1Layer = 3,
	node1 = 2,
	heroResName = 1
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_motion_effect_layer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_motion_effect_layer, "configList", _configList)
	rawset(lua_character_motion_effect_layer, "configDict", _configDict)
end

setmetatable(lua_character_motion_effect_layer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_motion_effect_layer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_motion_effect_layer, "configList", nil)
	rawset(lua_character_motion_effect_layer, "configDict", nil)
end

return lua_character_motion_effect_layer
