-- chunkname: @modules/configs/excel2json/lua_activity114_round.lua

module("modules.configs.excel2json.lua_activity114_round", package.seeall)

local lua_activity114_round = {}
local fields = {
	desc = 5,
	storyId = 10,
	isSkip = 12,
	type = 4,
	eventId = 8,
	transition = 11,
	day = 2,
	banButton2 = 7,
	banButton1 = 6,
	id = 3,
	activityId = 1,
	preStoryId = 9
}
local primaryKey = {
	"activityId",
	"day",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity114_round_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_round, "configList", _configList)
	rawset(lua_activity114_round, "configDict", _configDict)
end

setmetatable(lua_activity114_round, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_round.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_round, "configList", nil)
	rawset(lua_activity114_round, "configDict", nil)
end

return lua_activity114_round
