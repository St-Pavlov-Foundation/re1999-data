-- chunkname: @modules/configs/excel2json/lua_activity231_mission.lua

module("modules.configs.excel2json.lua_activity231_mission", package.seeall)

local lua_activity231_mission = {}
local fields = {
	listenerType = 5,
	prepose = 8,
	unlockCondition = 3,
	desc = 4,
	listenerParam = 6,
	id = 2,
	maxProgress = 7,
	activityId = 1,
	bonus = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity231_mission_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_mission, "configList", _configList)
	rawset(lua_activity231_mission, "configDict", _configDict)
end

setmetatable(lua_activity231_mission, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_mission.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_mission, "configList", nil)
	rawset(lua_activity231_mission, "configDict", nil)
end

return lua_activity231_mission
