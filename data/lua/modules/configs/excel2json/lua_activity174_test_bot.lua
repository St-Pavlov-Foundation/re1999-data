-- chunkname: @modules/configs/excel2json/lua_activity174_test_bot.lua

module("modules.configs.excel2json.lua_activity174_test_bot", package.seeall)

local lua_activity174_test_bot = {}
local fields = {
	collection3 = 9,
	collection4 = 10,
	count = 2,
	collection1 = 7,
	costCoin = 12,
	role3 = 5,
	enhance = 11,
	role1 = 3,
	collection2 = 8,
	role4 = 6,
	robotId = 1,
	role2 = 4
}
local primaryKey = {
	"robotId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_test_bot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_test_bot, "configList", _configList)
	rawset(lua_activity174_test_bot, "configDict", _configDict)
end

setmetatable(lua_activity174_test_bot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_test_bot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_test_bot, "configList", nil)
	rawset(lua_activity174_test_bot, "configDict", nil)
end

return lua_activity174_test_bot
