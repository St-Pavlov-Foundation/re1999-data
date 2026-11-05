-- chunkname: @modules/configs/excel2json/lua_tower_compose_mod.lua

module("modules.configs.excel2json.lua_tower_compose_mod", package.seeall)

local lua_tower_compose_mod = {}
local fields = {
	monsterChange = 11,
	name = 6,
	slotPart = 10,
	skillChange = 12,
	isUnlock = 8,
	careerChange = 16,
	career = 7,
	desc = 9,
	type = 4,
	themeId = 2,
	icon = 17,
	level = 3,
	ruleAdd = 14,
	image = 18,
	ruleChange = 15,
	slot = 5,
	passiveSkillAdd = 13,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_compose_mod_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_mod, "configList", _configList)
	rawset(lua_tower_compose_mod, "configDict", _configDict)
end

setmetatable(lua_tower_compose_mod, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_mod.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_mod, "configList", nil)
	rawset(lua_tower_compose_mod, "configDict", nil)
end

return lua_tower_compose_mod
