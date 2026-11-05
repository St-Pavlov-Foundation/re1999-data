-- chunkname: @modules/configs/excel2json/lua_survival_hardness.lua

module("modules.configs.excel2json.lua_survival_hardness", package.seeall)

local lua_survival_hardness = {}
local fields = {
	versions = 2,
	isShow = 8,
	icon = 9,
	type = 4,
	titile = 10,
	scoreRate = 12,
	extendScoreFix = 13,
	desc = 11,
	lockDesc = 14,
	subtype = 5,
	seasons = 3,
	id = 1,
	optional = 7,
	level = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_hardness_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_hardness, "configList", _configList)
	rawset(lua_survival_hardness, "configDict", _configDict)
end

setmetatable(lua_survival_hardness, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_hardness.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_hardness, "configList", nil)
	rawset(lua_survival_hardness, "configDict", nil)
end

return lua_survival_hardness
