-- chunkname: @modules/configs/excel2json/lua_activity245_turntable.lua

module("modules.configs.excel2json.lua_activity245_turntable", package.seeall)

local lua_activity245_turntable = {}
local fields = {
	isSp = 8,
	isFirstBigReward = 7,
	weight = 3,
	reward = 4,
	spPanelTitle = 13,
	spPanelIcon = 11,
	spMainTitle = 12,
	mainShowIcon = 9,
	spMainIcon = 10,
	availableTime = 5,
	id = 1,
	isBigReward = 6,
	activityId = 2,
	sort = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity245_turntable_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity245_turntable, "configList", _configList)
	rawset(lua_activity245_turntable, "configDict", _configDict)
end

setmetatable(lua_activity245_turntable, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity245_turntable.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity245_turntable, "configList", nil)
	rawset(lua_activity245_turntable, "configDict", nil)
end

return lua_activity245_turntable
