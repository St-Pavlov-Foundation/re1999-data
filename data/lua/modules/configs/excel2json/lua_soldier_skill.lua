-- chunkname: @modules/configs/excel2json/lua_soldier_skill.lua

module("modules.configs.excel2json.lua_soldier_skill", package.seeall)

local lua_soldier_skill = {}
local fields = {
	triggerPoint = 9,
	effect = 10,
	growUpTime = 6,
	type = 4,
	roundTriggerCountLimit = 11,
	condition = 8,
	skillDes = 3,
	totalTriggerCountLimit = 12,
	growUploop = 7,
	skillId = 1,
	skillName = 2,
	active = 5
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	skillDes = 2,
	skillName = 1
}
local _configList, _configDict
local configPath = "configs.soldier_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_soldier_skill, "configList", _configList)
	rawset(lua_soldier_skill, "configDict", _configDict)
end

setmetatable(lua_soldier_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_soldier_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_soldier_skill, "configList", nil)
	rawset(lua_soldier_skill, "configDict", nil)
end

return lua_soldier_skill
