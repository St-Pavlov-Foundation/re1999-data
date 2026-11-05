-- chunkname: @modules/configs/excel2json/lua_dice_task.lua

module("modules.configs.excel2json.lua_dice_task", package.seeall)

local lua_dice_task = {}
local fields = {
	jumpId = 11,
	isOnline = 2,
	id = 1,
	bonusMail = 6,
	name = 4,
	listenerType = 8,
	desc = 5,
	listenerParam = 9,
	minType = 3,
	openLimit = 7,
	maxProgress = 10,
	activityId = 13,
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
local configPath = "configs.dice_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_task, "configList", _configList)
	rawset(lua_dice_task, "configDict", _configDict)
end

setmetatable(lua_dice_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_task, "configList", nil)
	rawset(lua_dice_task, "configDict", nil)
end

return lua_dice_task
