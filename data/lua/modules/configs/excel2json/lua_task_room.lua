-- chunkname: @modules/configs/excel2json/lua_task_room.lua

module("modules.configs.excel2json.lua_task_room", package.seeall)

local lua_task_room = {}
local fields = {
	bonusIcon = 20,
	name = 4,
	bonusMail = 9,
	maxFinishCount = 16,
	desc = 5,
	listenerParam = 14,
	needAccept = 8,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	order = 7,
	tips = 6,
	isOnline = 2,
	prepose = 11,
	listenerType = 13,
	onceBonus = 19,
	minType = 3,
	id = 1,
	needReset = 18,
	bonus = 17
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 4,
	minType = 1,
	name = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.task_room_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_room, "configList", _configList)
	rawset(lua_task_room, "configDict", _configDict)
end

setmetatable(lua_task_room, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_room.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_room, "configList", nil)
	rawset(lua_task_room, "configDict", nil)
end

return lua_task_room
