-- chunkname: @modules/configs/excel2json/lua_fight_monster_skin_idle_map.lua

module("modules.configs.excel2json.lua_fight_monster_skin_idle_map", package.seeall)

local lua_fight_monster_skin_idle_map = {}
local fields = {
	freezeAnimName = 4,
	idleAnimName = 2,
	giddyAnimName = 6,
	skinId = 1,
	sleepAnimName = 5,
	hitAnimName = 3
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_monster_skin_idle_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_monster_skin_idle_map, "configList", _configList)
	rawset(lua_fight_monster_skin_idle_map, "configDict", _configDict)
end

setmetatable(lua_fight_monster_skin_idle_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_monster_skin_idle_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_monster_skin_idle_map, "configList", nil)
	rawset(lua_fight_monster_skin_idle_map, "configDict", nil)
end

return lua_fight_monster_skin_idle_map
