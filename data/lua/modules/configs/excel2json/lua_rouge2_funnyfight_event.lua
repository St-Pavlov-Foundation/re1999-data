-- chunkname: @modules/configs/excel2json/lua_rouge2_funnyfight_event.lua

module("modules.configs.excel2json.lua_rouge2_funnyfight_event", package.seeall)

local lua_rouge2_funnyfight_event = {}
local fields = {
	idIndicator = 2,
	fightTaskinfo = 7,
	taskLevel = 3,
	fightTaskDetail = 8,
	isTopic = 5,
	fightTaskDesc = 6,
	id = 1,
	stage1Interactive = 9,
	nextTask = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	fightTaskinfo = 2,
	fightTaskDesc = 1,
	fightTaskDetail = 3
}
local _configList, _configDict
local configPath = "configs.rouge2_funnyfight_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_funnyfight_event, "configList", _configList)
	rawset(lua_rouge2_funnyfight_event, "configDict", _configDict)
end

setmetatable(lua_rouge2_funnyfight_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_funnyfight_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_funnyfight_event, "configList", nil)
	rawset(lua_rouge2_funnyfight_event, "configDict", nil)
end

return lua_rouge2_funnyfight_event
