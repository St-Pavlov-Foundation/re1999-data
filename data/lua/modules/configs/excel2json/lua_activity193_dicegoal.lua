-- chunkname: @modules/configs/excel2json/lua_activity193_dicegoal.lua

module("modules.configs.excel2json.lua_activity193_dicegoal", package.seeall)

local lua_activity193_dicegoal = {}
local fields = {
	goalname = 7,
	goaldesc = 8,
	lossrewards = 4,
	hardType = 2,
	mattername = 9,
	victoryrewards = 3,
	weight = 10,
	goalRange = 6,
	id = 1,
	bindingDice = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mattername = 3,
	goaldesc = 2,
	goalname = 1
}
local _configList, _configDict
local configPath = "configs.activity193_dicegoal_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity193_dicegoal, "configList", _configList)
	rawset(lua_activity193_dicegoal, "configDict", _configDict)
end

setmetatable(lua_activity193_dicegoal, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity193_dicegoal.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity193_dicegoal, "configList", nil)
	rawset(lua_activity193_dicegoal, "configDict", nil)
end

return lua_activity193_dicegoal
