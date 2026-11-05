-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a0_question.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a0_question", package.seeall)

local lua_hero_story_mode_v4a0_question = {}
local fields = {
	group = 2,
	title = 3,
	content = 4,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_v4a0_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_v4a0_question, "configList", _configList)
	rawset(lua_hero_story_mode_v4a0_question, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_v4a0_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_v4a0_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_v4a0_question, "configList", nil)
	rawset(lua_hero_story_mode_v4a0_question, "configDict", nil)
end

return lua_hero_story_mode_v4a0_question
