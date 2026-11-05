-- chunkname: @modules/configs/excel2json/lua_fight_skill_force_use.lua

module("modules.configs.excel2json.lua_fight_skill_force_use", package.seeall)

local lua_fight_skill_force_use = {}
local fields = {
	order = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skill_force_use_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skill_force_use, "configList", _configList)
	rawset(lua_fight_skill_force_use, "configDict", _configDict)
end

setmetatable(lua_fight_skill_force_use, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skill_force_use.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skill_force_use, "configList", nil)
	rawset(lua_fight_skill_force_use, "configDict", nil)
end

return lua_fight_skill_force_use
