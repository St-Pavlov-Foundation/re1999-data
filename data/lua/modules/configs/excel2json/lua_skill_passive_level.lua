-- chunkname: @modules/configs/excel2json/lua_skill_passive_level.lua

module("modules.configs.excel2json.lua_skill_passive_level", package.seeall)

local lua_skill_passive_level = {}
local fields = {
	skillGroup = 5,
	heroId = 1,
	skillPassive = 3,
	uiFilterSkill = 4,
	skillLevel = 2
}
local primaryKey = {
	"heroId",
	"skillLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skill_passive_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_passive_level, "configList", _configList)
	rawset(lua_skill_passive_level, "configDict", _configDict)
end

setmetatable(lua_skill_passive_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_passive_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_passive_level, "configList", nil)
	rawset(lua_skill_passive_level, "configDict", nil)
end

return lua_skill_passive_level
