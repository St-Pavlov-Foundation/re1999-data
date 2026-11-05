-- chunkname: @modules/configs/excel2json/lua_skill_talent.lua

module("modules.configs.excel2json.lua_skill_talent", package.seeall)

local lua_skill_talent = {}
local fields = {
	newSkills0 = 6,
	newSkills5 = 16,
	newSkills2 = 10,
	exchangeSkills4 = 13,
	sub = 2,
	newSkills3 = 12,
	exchangeSkills1 = 7,
	desc = 4,
	exchangeSkills3 = 11,
	newSkills4 = 14,
	newSkills1 = 8,
	exchangeSkills2 = 9,
	exchangeSkills0 = 5,
	exchangeSkills5 = 15,
	talentId = 1,
	level = 3
}
local primaryKey = {
	"talentId",
	"sub"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.skill_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_talent, "configList", _configList)
	rawset(lua_skill_talent, "configDict", _configDict)
end

setmetatable(lua_skill_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_talent, "configList", nil)
	rawset(lua_skill_talent, "configDict", nil)
end

return lua_skill_talent
