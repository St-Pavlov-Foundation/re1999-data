-- chunkname: @modules/configs/excel2json/lua_task_guide.lua

module("modules.configs.excel2json.lua_task_guide", package.seeall)

local lua_task_guide = {}
local fields = {
	maxProgress = 9,
	name = 5,
	isOnline = 2,
	bonusMail = 15,
	maxFinishCount = 10,
	part = 17,
	priority = 19,
	desc = 6,
	listenerParam = 8,
	chapter = 18,
	needAccept = 20,
	jumpId = 22,
	openLimit = 14,
	stage = 16,
	sortId = 12,
	activity = 11,
	prepose = 13,
	listenerType = 7,
	minType = 4,
	minTypeId = 3,
	id = 1,
	bonus = 21
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
local configPath = "configs.task_guide_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_guide, "configList", _configList)
	rawset(lua_task_guide, "configDict", _configDict)
end

setmetatable(lua_task_guide, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_guide.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_guide, "configList", nil)
	rawset(lua_task_guide, "configDict", nil)
end

return lua_task_guide
