-- chunkname: @modules/configs/excel2json/lua_tower_assist_boss.lua

module("modules.configs.excel2json.lua_tower_assist_boss", package.seeall)

local lua_tower_assist_boss = {}
local fields = {
	bossId = 1,
	teachSkills = 13,
	heartVariantId = 9,
	skinId = 5,
	name = 3,
	gender = 6,
	career = 4,
	passiveSkills = 12,
	bossPic = 17,
	bossDesc = 19,
	dmgType = 7,
	tag = 8,
	coldTime = 10,
	resMaxVal = 16,
	bossShadowPic = 18,
	resInitVal = 15,
	towerId = 2,
	activeSkills = 11,
	passiveSkillName = 14
}
local primaryKey = {
	"bossId"
}
local mlStringKey = {
	tag = 2,
	name = 1,
	passiveSkillName = 3
}
local _configList, _configDict
local configPath = "configs.tower_assist_boss_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_assist_boss, "configList", _configList)
	rawset(lua_tower_assist_boss, "configDict", _configDict)
end

setmetatable(lua_tower_assist_boss, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_assist_boss.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_assist_boss, "configList", nil)
	rawset(lua_tower_assist_boss, "configDict", nil)
end

return lua_tower_assist_boss
