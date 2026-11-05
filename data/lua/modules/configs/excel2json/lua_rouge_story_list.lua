-- chunkname: @modules/configs/excel2json/lua_rouge_story_list.lua

module("modules.configs.excel2json.lua_rouge_story_list", package.seeall)

local lua_rouge_story_list = {}
local fields = {
	stageId = 4,
	name = 7,
	levelIdDict = 6,
	id = 2,
	season = 1,
	image = 5,
	storyIdList = 3,
	desc = 8
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_story_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_story_list, "configList", _configList)
	rawset(lua_rouge_story_list, "configDict", _configDict)
end

setmetatable(lua_rouge_story_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_story_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_story_list, "configList", nil)
	rawset(lua_rouge_story_list, "configDict", nil)
end

return lua_rouge_story_list
