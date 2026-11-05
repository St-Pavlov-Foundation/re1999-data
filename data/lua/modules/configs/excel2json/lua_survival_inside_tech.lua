-- chunkname: @modules/configs/excel2json/lua_survival_inside_tech.lua

module("modules.configs.excel2json.lua_survival_inside_tech", package.seeall)

local lua_survival_inside_tech = {}
local fields = {
	cost = 9,
	name = 2,
	preNodes = 6,
	sign = 10,
	desc = 5,
	needLv = 7,
	point = 3,
	id = 1,
	icon = 4,
	addTalentIds = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_inside_tech_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_inside_tech, "configList", _configList)
	rawset(lua_survival_inside_tech, "configDict", _configDict)
end

setmetatable(lua_survival_inside_tech, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_inside_tech.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_inside_tech, "configList", nil)
	rawset(lua_survival_inside_tech, "configDict", nil)
end

return lua_survival_inside_tech
