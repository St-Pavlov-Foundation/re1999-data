-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_question.lua

module("modules.configs.excel2json.lua_chapter_puzzle_question", package.seeall)

local lua_chapter_puzzle_question = {}
local fields = {
	descEn = 5,
	answer = 9,
	question = 8,
	questionTitle = 6,
	title = 2,
	questionTitleEn = 7,
	desc = 4,
	titleEn = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	answer = 5,
	question = 4,
	questionTitle = 3,
	title = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.chapter_puzzle_question_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_puzzle_question, "configList", _configList)
	rawset(lua_chapter_puzzle_question, "configDict", _configDict)
end

setmetatable(lua_chapter_puzzle_question, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_puzzle_question.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_puzzle_question, "configList", nil)
	rawset(lua_chapter_puzzle_question, "configDict", nil)
end

return lua_chapter_puzzle_question
