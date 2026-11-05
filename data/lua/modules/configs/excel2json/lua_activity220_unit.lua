-- chunkname: @modules/configs/excel2json/lua_activity220_unit.lua

module("modules.configs.excel2json.lua_activity220_unit", package.seeall)

local lua_activity220_unit = {}
local fields = {
	prefab = 5,
	def = 8,
	hp = 9,
	type = 2,
	monsterSkill = 4,
	atkAnimator = 11,
	keyTime = 10,
	initialAnimator = 12,
	chooseAnimator2 = 14,
	npcId = 1,
	skill = 6,
	atk = 7,
	chooseAnimator1 = 13,
	attribute = 3
}
local primaryKey = {
	"npcId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_unit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_unit, "configList", _configList)
	rawset(lua_activity220_unit, "configDict", _configDict)
end

setmetatable(lua_activity220_unit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_unit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_unit, "configList", nil)
	rawset(lua_activity220_unit, "configDict", nil)
end

return lua_activity220_unit
