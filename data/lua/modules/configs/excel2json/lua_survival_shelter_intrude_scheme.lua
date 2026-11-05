-- chunkname: @modules/configs/excel2json/lua_survival_shelter_intrude_scheme.lua

module("modules.configs.excel2json.lua_survival_shelter_intrude_scheme", package.seeall)

local lua_survival_shelter_intrude_scheme = {}
local fields = {
	id = 1,
	icon = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_shelter_intrude_scheme_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_shelter_intrude_scheme, "configList", _configList)
	rawset(lua_survival_shelter_intrude_scheme, "configDict", _configDict)
end

setmetatable(lua_survival_shelter_intrude_scheme, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_shelter_intrude_scheme.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_shelter_intrude_scheme, "configList", nil)
	rawset(lua_survival_shelter_intrude_scheme, "configDict", nil)
end

return lua_survival_shelter_intrude_scheme
