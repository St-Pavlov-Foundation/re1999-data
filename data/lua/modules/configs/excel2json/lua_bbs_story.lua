-- chunkname: @modules/configs/excel2json/lua_bbs_story.lua

module("modules.configs.excel2json.lua_bbs_story", package.seeall)

local lua_bbs_story = {}
local fields = {
	stepId = 2,
	post = 3,
	storyId = 1
}
local primaryKey = {
	"storyId",
	"stepId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.bbs_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bbs_story, "configList", _configList)
	rawset(lua_bbs_story, "configDict", _configDict)
end

setmetatable(lua_bbs_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bbs_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bbs_story, "configList", nil)
	rawset(lua_bbs_story, "configDict", nil)
end

return lua_bbs_story
