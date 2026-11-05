-- chunkname: @modules/configs/excel2json/lua_skill_energy.lua

module("modules.configs.excel2json.lua_skill_energy", package.seeall)

local lua_skill_energy = {}
local fields = {
	energyType = 3,
	name = 2,
	count = 4,
	id = 1,
	isSpecialCard = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.skill_energy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_energy, "configList", _configList)
	rawset(lua_skill_energy, "configDict", _configDict)
end

setmetatable(lua_skill_energy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_energy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_energy, "configList", nil)
	rawset(lua_skill_energy, "configDict", nil)
end

return lua_skill_energy
