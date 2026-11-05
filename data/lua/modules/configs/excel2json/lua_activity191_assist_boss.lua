-- chunkname: @modules/configs/excel2json/lua_activity191_assist_boss.lua

module("modules.configs.excel2json.lua_activity191_assist_boss", package.seeall)

local lua_activity191_assist_boss = {}
local fields = {
	bossId = 1,
	passiveSkills = 14,
	powerMax = 10,
	skinId = 7,
	uniqueSkill = 13,
	gender = 8,
	career = 6,
	activeSkill2 = 12,
	condition = 5,
	activeSkill1 = 11,
	dmgType = 9,
	name = 2,
	relation = 4,
	icon = 18,
	activityId = 3,
	headIcon = 17,
	offset = 16,
	uiForm = 15,
	bossDesc = 19
}
local primaryKey = {
	"bossId"
}
local mlStringKey = {
	bossDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_assist_boss_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_assist_boss, "configList", _configList)
	rawset(lua_activity191_assist_boss, "configDict", _configDict)
end

setmetatable(lua_activity191_assist_boss, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_assist_boss.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_assist_boss, "configList", nil)
	rawset(lua_activity191_assist_boss, "configDict", nil)
end

return lua_activity191_assist_boss
