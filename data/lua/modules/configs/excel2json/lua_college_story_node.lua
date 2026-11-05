-- chunkname: @modules/configs/excel2json/lua_college_story_node.lua

module("modules.configs.excel2json.lua_college_story_node", package.seeall)

local lua_college_story_node = {}
local fields = {
	tracePoints = 9,
	effect = 5,
	unlockCost = 8,
	location = 7,
	themeId = 2,
	title = 3,
	pos = 6,
	type = 4,
	playFormat = 10,
	id = 1,
	playConfig = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.college_story_node_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_story_node, "configList", _configList)
	rawset(lua_college_story_node, "configDict", _configDict)
end

setmetatable(lua_college_story_node, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_story_node.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_story_node, "configList", nil)
	rawset(lua_college_story_node, "configDict", nil)
end

return lua_college_story_node
