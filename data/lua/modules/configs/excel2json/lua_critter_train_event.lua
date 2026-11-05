-- chunkname: @modules/configs/excel2json/lua_critter_train_event.lua

module("modules.configs.excel2json.lua_critter_train_event", package.seeall)

local lua_critter_train_event = {}
local fields = {
	roomDialogId = 12,
	name = 3,
	skilledStoryId = 11,
	type = 2,
	normalStoryId = 10,
	autoFinish = 14,
	content = 17,
	desc = 8,
	preferenceAttribute = 6,
	computeIncrRate = 13,
	maxCount = 15,
	effectAttribute = 9,
	cost = 16,
	addAttribute = 5,
	condition = 4,
	initStoryId = 7,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	content = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.critter_train_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_train_event, "configList", _configList)
	rawset(lua_critter_train_event, "configDict", _configDict)
end

setmetatable(lua_critter_train_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_train_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_train_event, "configList", nil)
	rawset(lua_critter_train_event, "configDict", nil)
end

return lua_critter_train_event
