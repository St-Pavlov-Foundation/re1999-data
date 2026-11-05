-- chunkname: @modules/configs/excel2json/lua_activity114_meeting.lua

module("modules.configs.excel2json.lua_activity114_meeting", package.seeall)

local lua_activity114_meeting = {}
local fields = {
	nameEng = 4,
	name = 3,
	banTurn = 10,
	tag = 11,
	events = 7,
	condition = 8,
	character = 6,
	id = 2,
	signature = 5,
	activityId = 1,
	des = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity114_meeting_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_meeting, "configList", _configList)
	rawset(lua_activity114_meeting, "configDict", _configDict)
end

setmetatable(lua_activity114_meeting, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_meeting.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_meeting, "configList", nil)
	rawset(lua_activity114_meeting, "configDict", nil)
end

return lua_activity114_meeting
