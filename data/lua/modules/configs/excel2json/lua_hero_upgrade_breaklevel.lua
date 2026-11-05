-- chunkname: @modules/configs/excel2json/lua_hero_upgrade_breaklevel.lua

module("modules.configs.excel2json.lua_hero_upgrade_breaklevel", package.seeall)

local lua_hero_upgrade_breaklevel = {}
local fields = {
	upgradeSkillId = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_upgrade_breaklevel_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_upgrade_breaklevel, "configList", _configList)
	rawset(lua_hero_upgrade_breaklevel, "configDict", _configDict)
end

setmetatable(lua_hero_upgrade_breaklevel, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_upgrade_breaklevel.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_upgrade_breaklevel, "configList", nil)
	rawset(lua_hero_upgrade_breaklevel, "configDict", nil)
end

return lua_hero_upgrade_breaklevel
