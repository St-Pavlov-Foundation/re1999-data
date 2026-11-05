-- chunkname: @modules/configs/excel2json/lua_sonnet_task.lua

module("modules.configs.excel2json.lua_sonnet_task", package.seeall)

local lua_sonnet_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	chapterId = 2,
	episodeId = 10,
	listenerType = 7,
	isGrandPrize = 13,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.sonnet_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sonnet_task, "configList", _configList)
	rawset(lua_sonnet_task, "configDict", _configDict)
end

setmetatable(lua_sonnet_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sonnet_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sonnet_task, "configList", nil)
	rawset(lua_sonnet_task, "configDict", nil)
end

return lua_sonnet_task
