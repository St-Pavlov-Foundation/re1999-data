-- chunkname: @modules/configs/excel2json/lua_fight_tower_500m_boss_behaviour.lua

module("modules.configs.excel2json.lua_fight_tower_500m_boss_behaviour", package.seeall)

local lua_fight_tower_500m_boss_behaviour = {}
local fields = {
	monsterid = 2,
	param2 = 4,
	hpColor = 13,
	param1 = 3,
	hpBgColor = 12,
	param3 = 5,
	param9 = 11,
	param7 = 9,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param4 = 6,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_tower_500m_boss_behaviour_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_tower_500m_boss_behaviour, "configList", _configList)
	rawset(lua_fight_tower_500m_boss_behaviour, "configDict", _configDict)
end

setmetatable(lua_fight_tower_500m_boss_behaviour, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_tower_500m_boss_behaviour.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_tower_500m_boss_behaviour, "configList", nil)
	rawset(lua_fight_tower_500m_boss_behaviour, "configDict", nil)
end

return lua_fight_tower_500m_boss_behaviour
