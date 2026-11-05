-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_ly.lua

module("modules.configs.excel2json.lua_fight_sp_effect_ly", package.seeall)

local lua_fight_sp_effect_ly = {}
local fields = {
	spine1EffectRes = 5,
	spine2Res = 6,
	fadeAudioId = 9,
	spine1Res = 4,
	pos = 3,
	path = 2,
	audioId = 8,
	spine2EffectRes = 7,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_ly_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_ly, "configList", _configList)
	rawset(lua_fight_sp_effect_ly, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_ly, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_ly.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_ly, "configList", nil)
	rawset(lua_fight_sp_effect_ly, "configDict", nil)
end

return lua_fight_sp_effect_ly
