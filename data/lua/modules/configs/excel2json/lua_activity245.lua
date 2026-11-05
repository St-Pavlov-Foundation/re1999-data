-- chunkname: @modules/configs/excel2json/lua_activity245.lua

module("modules.configs.excel2json.lua_activity245", package.seeall)

local lua_activity245 = {}
local fields = {
	cost = 6,
	ticketLimit = 5,
	ticketId = 2,
	loginActivityId = 7,
	dailyTicket = 4,
	firstTicket = 3,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity245_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity245, "configList", _configList)
	rawset(lua_activity245, "configDict", _configDict)
end

setmetatable(lua_activity245, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity245.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity245, "configList", nil)
	rawset(lua_activity245, "configDict", nil)
end

return lua_activity245
