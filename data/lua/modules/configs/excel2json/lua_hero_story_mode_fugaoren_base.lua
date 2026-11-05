-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_fugaoren_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_fugaoren_base", package.seeall)

local lua_hero_story_mode_fugaoren_base = {}
local fields = {
	costTime = 4,
	areaId = 5,
	preId = 7,
	type = 3,
	name = 2,
	id = 1,
	storyId = 12,
	resource = 15,
	unlockAreaId = 6,
	rightChoose = 14,
	weather = 16,
	endTime = 10,
	conArea = 8,
	dialogId = 11,
	choose = 13,
	startTime = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	choose = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_mode_fugaoren_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_fugaoren_base, "configList", _configList)
	rawset(lua_hero_story_mode_fugaoren_base, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_fugaoren_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_fugaoren_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_fugaoren_base, "configList", nil)
	rawset(lua_hero_story_mode_fugaoren_base, "configDict", nil)
end

return lua_hero_story_mode_fugaoren_base
