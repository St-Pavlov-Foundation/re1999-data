-- chunkname: @modules/configs/excel2json/lua_equip_skill.lua

module("modules.configs.excel2json.lua_equip_skill", package.seeall)

local lua_equip_skill = {}
local fields = {
	skill = 3,
	skill2 = 4,
	skillHide = 5,
	dropDmg = 16,
	heal = 17,
	defenseIgnore = 19,
	career = 6,
	absorb = 20,
	addDmg = 15,
	normalSkillRate = 21,
	baseDesc = 7,
	criDmg = 13,
	attack = 9,
	criDef = 14,
	clutch = 22,
	skillLv = 2,
	baseDesc2 = 23,
	cri = 11,
	revive = 18,
	recri = 12,
	condition = 8,
	hp = 10,
	id = 1
}
local primaryKey = {
	"id",
	"skillLv"
}
local mlStringKey = {
	baseDesc = 1,
	baseDesc2 = 2
}
local _configList, _configDict
local configPath = "configs.equip_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_skill, "configList", _configList)
	rawset(lua_equip_skill, "configDict", _configDict)
end

setmetatable(lua_equip_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_skill, "configList", nil)
	rawset(lua_equip_skill, "configDict", nil)
end

return lua_equip_skill
