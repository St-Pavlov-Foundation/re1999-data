-- chunkname: @modules/configs/excel2json/lua_fight_die_act_enemyus.lua

module("modules.configs.excel2json.lua_fight_die_act_enemyus", package.seeall)

local lua_fight_die_act_enemyus = {}
local fields = {
	id = 1,
	act = 3,
	playEffect = 4,
	enemyus = 2
}
local primaryKey = {
	"id",
	"enemyus"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_die_act_enemyus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_die_act_enemyus, "configList", _configList)
	rawset(lua_fight_die_act_enemyus, "configDict", _configDict)
end

setmetatable(lua_fight_die_act_enemyus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_die_act_enemyus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_die_act_enemyus, "configList", nil)
	rawset(lua_fight_die_act_enemyus, "configDict", nil)
end

return lua_fight_die_act_enemyus
