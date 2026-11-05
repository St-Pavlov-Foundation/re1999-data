-- chunkname: @modules/configs/excel2json/lua_activity203_skill.lua

module("modules.configs.excel2json.lua_activity203_skill", package.seeall)

local lua_activity203_skill = {}
local fields = {
	description = 4,
	name = 3,
	coolDown = 7,
	skillId = 1,
	effect = 6,
	icon = 5,
	target = 2
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity203_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity203_skill, "configList", _configList)
	rawset(lua_activity203_skill, "configDict", _configDict)
end

setmetatable(lua_activity203_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity203_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity203_skill, "configList", nil)
	rawset(lua_activity203_skill, "configDict", nil)
end

return lua_activity203_skill
