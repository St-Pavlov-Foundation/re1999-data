-- chunkname: @modules/configs/excel2json/lua_survival_hardness_mod.lua

module("modules.configs.excel2json.lua_survival_hardness_mod", package.seeall)

local lua_survival_hardness_mod = {}
local fields = {
	unlock = 8,
	extendScore = 6,
	name = 2,
	subTab = 4,
	hardness = 5,
	initRole = 9,
	desc = 7,
	id = 1,
	optional = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_hardness_mod_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_hardness_mod, "configList", _configList)
	rawset(lua_survival_hardness_mod, "configDict", _configDict)
end

setmetatable(lua_survival_hardness_mod, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_hardness_mod.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_hardness_mod, "configList", nil)
	rawset(lua_survival_hardness_mod, "configDict", nil)
end

return lua_survival_hardness_mod
