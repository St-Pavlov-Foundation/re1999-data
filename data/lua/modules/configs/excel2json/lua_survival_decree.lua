-- chunkname: @modules/configs/excel2json/lua_survival_decree.lua

module("modules.configs.excel2json.lua_survival_decree", package.seeall)

local lua_survival_decree = {}
local fields = {
	versions = 3,
	name = 5,
	group = 2,
	seasons = 4,
	id = 1,
	icon = 7,
	getTalents = 8,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_decree_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_decree, "configList", _configList)
	rawset(lua_survival_decree, "configDict", _configDict)
end

setmetatable(lua_survival_decree, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_decree.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_decree, "configList", nil)
	rawset(lua_survival_decree, "configDict", nil)
end

return lua_survival_decree
