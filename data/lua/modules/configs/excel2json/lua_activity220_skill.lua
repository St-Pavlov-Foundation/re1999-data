-- chunkname: @modules/configs/excel2json/lua_activity220_skill.lua

module("modules.configs.excel2json.lua_activity220_skill", package.seeall)

local lua_activity220_skill = {}
local fields = {
	skillId = 1,
	name = 2,
	target1 = 12,
	param1 = 13,
	cooldown1 = 7,
	timing1 = 10,
	condition2 = 17,
	desc = 3,
	target2 = 18,
	param2 = 19,
	cooldown3 = 21,
	timing2 = 16,
	condition3 = 22,
	icon = 6,
	percent2 = 14,
	cooldown2 = 15,
	timing3 = 20,
	rare = 5,
	target3 = 23,
	count1 = 9,
	condition1 = 11,
	percent1 = 8,
	weight = 4,
	param3 = 24
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity220_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_skill, "configList", _configList)
	rawset(lua_activity220_skill, "configDict", _configDict)
end

setmetatable(lua_activity220_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_skill, "configList", nil)
	rawset(lua_activity220_skill, "configDict", nil)
end

return lua_activity220_skill
