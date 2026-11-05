-- chunkname: @modules/configs/excel2json/lua_fight_direct_switch_battle_when_end.lua

module("modules.configs.excel2json.lua_fight_direct_switch_battle_when_end", package.seeall)

local lua_fight_direct_switch_battle_when_end = {}
local fields = {
	id = 1,
	nextEpisodeId = 3,
	nextBattleId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_direct_switch_battle_when_end_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_direct_switch_battle_when_end, "configList", _configList)
	rawset(lua_fight_direct_switch_battle_when_end, "configDict", _configDict)
end

setmetatable(lua_fight_direct_switch_battle_when_end, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_direct_switch_battle_when_end.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_direct_switch_battle_when_end, "configList", nil)
	rawset(lua_fight_direct_switch_battle_when_end, "configDict", nil)
end

return lua_fight_direct_switch_battle_when_end
