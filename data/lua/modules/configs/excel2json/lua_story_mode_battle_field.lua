-- chunkname: @modules/configs/excel2json/lua_story_mode_battle_field.lua

module("modules.configs.excel2json.lua_story_mode_battle_field", package.seeall)

local lua_story_mode_battle_field = {}
local fields = {
	heroGroupTypeId = 4,
	chapterMapIds = 5,
	chapterId = 1,
	fieldId = 2,
	episodeIds = 3
}
local primaryKey = {
	"chapterId",
	"fieldId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_mode_battle_field_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_mode_battle_field, "configList", _configList)
	rawset(lua_story_mode_battle_field, "configDict", _configDict)
end

setmetatable(lua_story_mode_battle_field, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_mode_battle_field.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_mode_battle_field, "configList", nil)
	rawset(lua_story_mode_battle_field, "configDict", nil)
end

return lua_story_mode_battle_field
