-- chunkname: @modules/configs/excel2json/lua_fight_gao_si_niao_buffeffect_electric_level.lua

module("modules.configs.excel2json.lua_fight_gao_si_niao_buffeffect_electric_level", package.seeall)

local lua_fight_gao_si_niao_buffeffect_electric_level = {}
local fields = {
	electricLevel = 3,
	effect = 4,
	effectHangPoint = 5,
	audio = 6,
	id = 1,
	skin = 2
}
local primaryKey = {
	"id",
	"skin",
	"electricLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_gao_si_niao_buffeffect_electric_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_gao_si_niao_buffeffect_electric_level, "configList", _configList)
	rawset(lua_fight_gao_si_niao_buffeffect_electric_level, "configDict", _configDict)
end

setmetatable(lua_fight_gao_si_niao_buffeffect_electric_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_gao_si_niao_buffeffect_electric_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_gao_si_niao_buffeffect_electric_level, "configList", nil)
	rawset(lua_fight_gao_si_niao_buffeffect_electric_level, "configDict", nil)
end

return lua_fight_gao_si_niao_buffeffect_electric_level
