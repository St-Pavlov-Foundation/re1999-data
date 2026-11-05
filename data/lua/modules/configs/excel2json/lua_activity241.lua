-- chunkname: @modules/configs/excel2json/lua_activity241.lua

module("modules.configs.excel2json.lua_activity241", package.seeall)

local lua_activity241 = {}
local fields = {
	ticketCurrencyId = 4,
	ticketLimit = 5,
	voteId = 6,
	dailyTicket = 3,
	openDays = 2,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity241_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity241, "configList", _configList)
	rawset(lua_activity241, "configDict", _configDict)
end

setmetatable(lua_activity241, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity241.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity241, "configList", nil)
	rawset(lua_activity241, "configDict", nil)
end

return lua_activity241
