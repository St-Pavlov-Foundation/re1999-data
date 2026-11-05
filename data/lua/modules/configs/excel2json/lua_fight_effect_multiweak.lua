-- chunkname: @modules/configs/excel2json/lua_fight_effect_multiweak.lua

module("modules.configs.excel2json.lua_fight_effect_multiweak", package.seeall)

local lua_fight_effect_multiweak = {}
local fields = {
	id = 1,
	career = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_effect_multiweak_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_effect_multiweak, "configList", _configList)
	rawset(lua_fight_effect_multiweak, "configDict", _configDict)
end

setmetatable(lua_fight_effect_multiweak, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_effect_multiweak.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_effect_multiweak, "configList", nil)
	rawset(lua_fight_effect_multiweak, "configDict", nil)
end

return lua_fight_effect_multiweak
