-- chunkname: @modules/configs/excel2json/lua_story_audio_branch.lua

module("modules.configs.excel2json.lua_story_audio_branch", package.seeall)

local lua_story_audio_branch = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_audio_branch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_audio_branch, "configList", _configList)
	rawset(lua_story_audio_branch, "configDict", _configDict)
end

setmetatable(lua_story_audio_branch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_audio_branch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_audio_branch, "configList", nil)
	rawset(lua_story_audio_branch, "configDict", nil)
end

return lua_story_audio_branch
