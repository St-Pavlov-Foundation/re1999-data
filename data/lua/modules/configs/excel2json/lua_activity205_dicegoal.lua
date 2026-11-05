-- chunkname: @modules/configs/excel2json/lua_activity205_dicegoal.lua

module("modules.configs.excel2json.lua_activity205_dicegoal", package.seeall)

local lua_activity205_dicegoal = {}
local fields = {
	winRewardId = 3,
	goaldesc = 8,
	hardType = 2,
	goalname = 7,
	iconRes = 9,
	weight = 10,
	goalRange = 6,
	failRewardId = 4,
	id = 1,
	bindingDice = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	goalname = 1,
	goaldesc = 2
}
local _configList, _configDict
local configPath = "configs.activity205_dicegoal_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity205_dicegoal, "configList", _configList)
	rawset(lua_activity205_dicegoal, "configDict", _configDict)
end

setmetatable(lua_activity205_dicegoal, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity205_dicegoal.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity205_dicegoal, "configList", nil)
	rawset(lua_activity205_dicegoal, "configDict", nil)
end

return lua_activity205_dicegoal
