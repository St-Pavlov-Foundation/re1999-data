-- chunkname: @modules/configs/excel2json/lua_survival_role_skill.lua

module("modules.configs.excel2json.lua_survival_role_skill", package.seeall)

local lua_survival_role_skill = {}
local fields = {
	effect1 = 6,
	resource = 3,
	times = 4,
	effect2 = 7,
	id = 1,
	effect3 = 8,
	addTalentIds = 5,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_role_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_role_skill, "configList", _configList)
	rawset(lua_survival_role_skill, "configDict", _configDict)
end

setmetatable(lua_survival_role_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_role_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_role_skill, "configList", nil)
	rawset(lua_survival_role_skill, "configDict", nil)
end

return lua_survival_role_skill
