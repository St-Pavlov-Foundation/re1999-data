-- chunkname: @modules/configs/excel2json/lua_tower_v3a7_story.lua

module("modules.configs.excel2json.lua_tower_v3a7_story", package.seeall)

local lua_tower_v3a7_story = {}
local fields = {
	head = 3,
	id = 1,
	dialogue = 4,
	occur = 5,
	order = 2
}
local primaryKey = {
	"id",
	"order"
}
local mlStringKey = {
	dialogue = 1
}
local _configList, _configDict
local configPath = "configs.tower_v3a7_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_v3a7_story, "configList", _configList)
	rawset(lua_tower_v3a7_story, "configDict", _configDict)
end

setmetatable(lua_tower_v3a7_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_v3a7_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_v3a7_story, "configList", nil)
	rawset(lua_tower_v3a7_story, "configDict", nil)
end

return lua_tower_v3a7_story
