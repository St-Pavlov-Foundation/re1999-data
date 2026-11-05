-- chunkname: @modules/configs/excel2json/lua_chapter_map_element_dispatch.lua

module("modules.configs.excel2json.lua_chapter_map_element_dispatch", package.seeall)

local lua_chapter_map_element_dispatch = {}
local fields = {
	desc = 8,
	id = 1,
	time = 4,
	image = 9,
	title = 7,
	unlockLineNumbers = 12,
	extraParam = 6,
	elementId = 10,
	shortType = 5,
	minCount = 2,
	maxCount = 3,
	activityId = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.chapter_map_element_dispatch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_map_element_dispatch, "configList", _configList)
	rawset(lua_chapter_map_element_dispatch, "configDict", _configDict)
end

setmetatable(lua_chapter_map_element_dispatch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_map_element_dispatch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_map_element_dispatch, "configList", nil)
	rawset(lua_chapter_map_element_dispatch, "configDict", nil)
end

return lua_chapter_map_element_dispatch
