-- chunkname: @modules/configs/excel2json/lua_activity174_bet.lua

module("modules.configs.excel2json.lua_activity174_bet", package.seeall)

local lua_activity174_bet = {}
local fields = {
	ratio = 3,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_bet_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_bet, "configList", _configList)
	rawset(lua_activity174_bet, "configDict", _configDict)
end

setmetatable(lua_activity174_bet, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_bet.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_bet, "configList", nil)
	rawset(lua_activity174_bet, "configDict", nil)
end

return lua_activity174_bet
