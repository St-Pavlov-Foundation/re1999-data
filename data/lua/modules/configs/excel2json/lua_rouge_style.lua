-- chunkname: @modules/configs/excel2json/lua_rouge_style.lua

module("modules.configs.excel2json.lua_rouge_style", package.seeall)

local lua_rouge_style = {}
local fields = {
	coin = 8,
	name = 4,
	talentPointGroup = 17,
	layoutId = 11,
	season = 1,
	mapSkills = 15,
	passiveSkillDescs = 12,
	desc = 5,
	unlockType = 18,
	capacity = 7,
	talentSkill = 16,
	power = 9,
	icon = 6,
	unlockParam = 19,
	halfCost = 20,
	activeSkills = 14,
	passiveSkillDescs2 = 13,
	id = 2,
	version = 3,
	powerLimit = 10
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	passiveSkillDescs2 = 4,
	name = 1,
	passiveSkillDescs = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge_style_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_style, "configList", _configList)
	rawset(lua_rouge_style, "configDict", _configDict)
end

setmetatable(lua_rouge_style, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_style.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_style, "configList", nil)
	rawset(lua_rouge_style, "configDict", nil)
end

return lua_rouge_style
