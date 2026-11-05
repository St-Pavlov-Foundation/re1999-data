-- chunkname: @modules/configs/excel2json/lua_activity191_fight_event.lua

module("modules.configs.excel2json.lua_activity191_fight_event", package.seeall)

local lua_activity191_fight_event = {}
local fields = {
	fightLevel = 12,
	autoRewardView = 9,
	bloodAward = 10,
	type = 3,
	skinId = 6,
	title = 4,
	offset = 7,
	episodeId = 5,
	rewardView = 8,
	autoAward = 11,
	id = 1,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity191_fight_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_fight_event, "configList", _configList)
	rawset(lua_activity191_fight_event, "configDict", _configDict)
end

setmetatable(lua_activity191_fight_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_fight_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_fight_event, "configList", nil)
	rawset(lua_activity191_fight_event, "configDict", nil)
end

return lua_activity191_fight_event
