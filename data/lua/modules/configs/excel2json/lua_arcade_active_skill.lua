-- chunkname: @modules/configs/excel2json/lua_arcade_active_skill.lua

module("modules.configs.excel2json.lua_arcade_active_skill", package.seeall)

local lua_arcade_active_skill = {}
local fields = {
	damage = 4,
	icon = 6,
	bulletEffect = 8,
	hitEffect = 9,
	target = 5,
	spellEffect = 7,
	id = 1,
	skillName = 2,
	skillDesc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	skillName = 1
}
local _configList, _configDict
local configPath = "configs.arcade_active_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_active_skill, "configList", _configList)
	rawset(lua_arcade_active_skill, "configDict", _configDict)
end

setmetatable(lua_arcade_active_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_active_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_active_skill, "configList", nil)
	rawset(lua_arcade_active_skill, "configDict", nil)
end

return lua_arcade_active_skill
