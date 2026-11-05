-- chunkname: @modules/configs/excel2json/lua_rouge2_passive_skill.lua

module("modules.configs.excel2json.lua_rouge2_passive_skill", package.seeall)

local lua_rouge2_passive_skill = {}
local fields = {
	isSpecial = 11,
	name = 3,
	effectDesc = 5,
	upDesc = 6,
	icon = 9,
	attribute = 10,
	id = 1,
	desc = 4,
	levelUpDesc = 7,
	imLevelUpDesc = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effectDesc = 3,
	name = 1,
	levelUpDesc = 5,
	upDesc = 4,
	imLevelUpDesc = 6,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_passive_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_passive_skill, "configList", _configList)
	rawset(lua_rouge2_passive_skill, "configDict", _configDict)
end

setmetatable(lua_rouge2_passive_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_passive_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_passive_skill, "configList", nil)
	rawset(lua_rouge2_passive_skill, "configDict", nil)
end

return lua_rouge2_passive_skill
