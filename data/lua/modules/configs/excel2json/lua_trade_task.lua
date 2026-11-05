-- chunkname: @modules/configs/excel2json/lua_trade_task.lua

module("modules.configs.excel2json.lua_trade_task", package.seeall)

local lua_trade_task = {}
local fields = {
	sortId = 6,
	isOnline = 14,
	extraBonus = 12,
	speaker = 9,
	logtext = 10,
	icon = 11,
	listenerType = 3,
	desc = 2,
	listenerParam = 4,
	minType = 15,
	maxProgress = 5,
	jumpId = 13,
	id = 1,
	addRoomLog = 8,
	tradeLevel = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	minType = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.trade_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trade_task, "configList", _configList)
	rawset(lua_trade_task, "configDict", _configDict)
end

setmetatable(lua_trade_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trade_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trade_task, "configList", nil)
	rawset(lua_trade_task, "configDict", nil)
end

return lua_trade_task
