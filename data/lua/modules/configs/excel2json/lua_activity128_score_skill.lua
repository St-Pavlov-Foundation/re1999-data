-- chunkname: @modules/configs/excel2json/lua_activity128_score_skill.lua

module("modules.configs.excel2json.lua_activity128_score_skill", package.seeall)

local lua_activity128_score_skill = {}
local fields = {
	skillEx = 7,
	skillGroup1 = 5,
	newPassiveSkill = 8,
	score = 4,
	icon = 11,
	skillGroup2 = 6,
	spDesc = 12,
	episodeId = 1,
	hidden = 10,
	monsterId = 3,
	phase = 2,
	replacePassiveSkill = 9
}
local primaryKey = {
	"episodeId",
	"phase",
	"monsterId"
}
local mlStringKey = {
	spDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity128_score_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_score_skill, "configList", _configList)
	rawset(lua_activity128_score_skill, "configDict", _configDict)
end

setmetatable(lua_activity128_score_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_score_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_score_skill, "configList", nil)
	rawset(lua_activity128_score_skill, "configDict", nil)
end

return lua_activity128_score_skill
