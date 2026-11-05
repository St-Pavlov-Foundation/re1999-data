-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_music_ball_skill.lua

module("modules.configs.excel2json.lua_fight_rouge2_music_ball_skill", package.seeall)

local lua_fight_rouge2_music_ball_skill = {}
local fields = {
	condition1 = 3,
	behavior1 = 4,
	condition2 = 5,
	skillId = 1,
	condition3 = 7,
	icon = 2,
	behavior3 = 8,
	behavior2 = 6
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_rouge2_music_ball_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_rouge2_music_ball_skill, "configList", _configList)
	rawset(lua_fight_rouge2_music_ball_skill, "configDict", _configDict)
end

setmetatable(lua_fight_rouge2_music_ball_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_rouge2_music_ball_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_rouge2_music_ball_skill, "configList", nil)
	rawset(lua_fight_rouge2_music_ball_skill, "configDict", nil)
end

return lua_fight_rouge2_music_ball_skill
