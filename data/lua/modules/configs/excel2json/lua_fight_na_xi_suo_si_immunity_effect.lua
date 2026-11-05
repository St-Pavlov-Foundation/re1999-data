-- chunkname: @modules/configs/excel2json/lua_fight_na_xi_suo_si_immunity_effect.lua

module("modules.configs.excel2json.lua_fight_na_xi_suo_si_immunity_effect", package.seeall)

local lua_fight_na_xi_suo_si_immunity_effect = {}
local fields = {
	effect = 2,
	effectHang = 3,
	audio = 4,
	id = 1,
	duration = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_na_xi_suo_si_immunity_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_na_xi_suo_si_immunity_effect, "configList", _configList)
	rawset(lua_fight_na_xi_suo_si_immunity_effect, "configDict", _configDict)
end

setmetatable(lua_fight_na_xi_suo_si_immunity_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_na_xi_suo_si_immunity_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_na_xi_suo_si_immunity_effect, "configList", nil)
	rawset(lua_fight_na_xi_suo_si_immunity_effect, "configDict", nil)
end

return lua_fight_na_xi_suo_si_immunity_effect
