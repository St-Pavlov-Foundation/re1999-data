-- chunkname: @modules/configs/excel2json/lua_stronghold_skill.lua

module("modules.configs.excel2json.lua_stronghold_skill", package.seeall)

local lua_stronghold_skill = {}
local fields = {
	triggerPoint = 3,
	effect = 4,
	roundTriggerCountLimit = 5,
	skillId = 1,
	totalTriggerCountLimit = 6,
	condition = 2
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.stronghold_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stronghold_skill, "configList", _configList)
	rawset(lua_stronghold_skill, "configDict", _configDict)
end

setmetatable(lua_stronghold_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stronghold_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stronghold_skill, "configList", nil)
	rawset(lua_stronghold_skill, "configDict", nil)
end

return lua_stronghold_skill
