-- chunkname: @modules/configs/excel2json/lua_skill_ex_level.lua

module("modules.configs.excel2json.lua_skill_ex_level", package.seeall)

local lua_skill_ex_level = {}
local fields = {
	skillEx = 10,
	passiveSkill = 11,
	consume = 3,
	skillGroup1 = 8,
	deviceId = 6,
	skillGroup2 = 9,
	desc = 5,
	skillLevel = 2,
	heroId = 1,
	consume2 = 12,
	requirement = 4,
	qteGoupId = 7
}
local primaryKey = {
	"heroId",
	"skillLevel"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.skill_ex_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_ex_level, "configList", _configList)
	rawset(lua_skill_ex_level, "configDict", _configDict)
end

setmetatable(lua_skill_ex_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_ex_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_ex_level, "configList", nil)
	rawset(lua_skill_ex_level, "configDict", nil)
end

return lua_skill_ex_level
