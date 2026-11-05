-- chunkname: @modules/configs/excel2json/lua_activity191_bot.lua

module("modules.configs.excel2json.lua_activity191_bot", package.seeall)

local lua_activity191_bot = {}
local fields = {
	enhance = 15,
	role3 = 5,
	collection3 = 13,
	prepareRole3 = 9,
	prepareRole1 = 7,
	rank = 17,
	powerInitial = 16,
	role1 = 3,
	prepareRole2 = 8,
	activityId = 2,
	role2 = 4,
	prepareRole4 = 10,
	collection1 = 11,
	collection4 = 14,
	collection2 = 12,
	role4 = 6,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_bot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_bot, "configList", _configList)
	rawset(lua_activity191_bot, "configDict", _configDict)
end

setmetatable(lua_activity191_bot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_bot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_bot, "configList", nil)
	rawset(lua_activity191_bot, "configDict", nil)
end

return lua_activity191_bot
