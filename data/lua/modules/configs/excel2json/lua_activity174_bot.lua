-- chunkname: @modules/configs/excel2json/lua_activity174_bot.lua

module("modules.configs.excel2json.lua_activity174_bot", package.seeall)

local lua_activity174_bot = {}
local fields = {
	role2 = 8,
	collection3 = 13,
	count = 6,
	collection1 = 11,
	season = 3,
	role3 = 9,
	enhance = 15,
	collection4 = 14,
	role1 = 7,
	collection2 = 12,
	role4 = 10,
	id = 1,
	robotId = 4,
	activityId = 2,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_bot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_bot, "configList", _configList)
	rawset(lua_activity174_bot, "configDict", _configDict)
end

setmetatable(lua_activity174_bot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_bot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_bot, "configList", nil)
	rawset(lua_activity174_bot, "configDict", nil)
end

return lua_activity174_bot
