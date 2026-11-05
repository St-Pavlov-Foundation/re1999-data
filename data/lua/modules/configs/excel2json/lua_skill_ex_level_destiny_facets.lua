-- chunkname: @modules/configs/excel2json/lua_skill_ex_level_destiny_facets.lua

module("modules.configs.excel2json.lua_skill_ex_level_destiny_facets", package.seeall)

local lua_skill_ex_level_destiny_facets = {}
local fields = {
	skillEx = 6,
	passiveSkill = 7,
	desc = 3,
	facetsId = 1,
	skillLevel = 2,
	skillGroup2 = 5,
	skillGroup1 = 4
}
local primaryKey = {
	"facetsId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.skill_ex_level_destiny_facets_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_ex_level_destiny_facets, "configList", _configList)
	rawset(lua_skill_ex_level_destiny_facets, "configDict", _configDict)
end

setmetatable(lua_skill_ex_level_destiny_facets, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_ex_level_destiny_facets.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_ex_level_destiny_facets, "configList", nil)
	rawset(lua_skill_ex_level_destiny_facets, "configDict", nil)
end

return lua_skill_ex_level_destiny_facets
