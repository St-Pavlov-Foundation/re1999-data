-- chunkname: @modules/configs/excel2json/lua_monster_template.lua

module("modules.configs.excel2json.lua_monster_template", package.seeall)

local lua_monster_template = {}
local fields = {
	defense = 5,
	mdefense = 6,
	technic = 7,
	dropDmg = 13,
	criDmg = 10,
	criGrow = 19,
	criDefGrow = 22,
	technicGrow = 18,
	addDmg = 12,
	addDmgGrow = 23,
	recriGrow = 20,
	attackGrow = 15,
	attack = 4,
	criDef = 11,
	mdefenseGrow = 17,
	defenseGrow = 16,
	dropDmgGrow = 24,
	cri = 8,
	multiHp = 3,
	recri = 9,
	template = 1,
	life = 2,
	lifeGrow = 14,
	criDmgGrow = 21
}
local primaryKey = {
	"template"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.monster_template_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_template, "configList", _configList)
	rawset(lua_monster_template, "configDict", _configDict)
end

setmetatable(lua_monster_template, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_template.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_template, "configList", nil)
	rawset(lua_monster_template, "configDict", nil)
end

return lua_monster_template
